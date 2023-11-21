//
//  RegisterScheduleViewModel.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/15/23.
//

import Foundation

fileprivate enum MediCheckAPI {
    static let scheme = "http"
    static let host = "yuno.hopto.org"
    
    enum Path: String {
        case medicine_schedule = "/medicine/schedule"
        case medicine_delete = "/medicine/delete"
        case medicine_check_take = "/medicine/check/take"
    }
}

class RegisterScheduleViewModel: ObservableObject {
    @Published var schedules: [MyScheduleDTO] = []
    @Published var medicines: [MyMedicineDTO] = []
    
    @MainActor
    func fetchData(week: [String], medicineName: String, memberName: String, time: [String], takeAmount: Int) async {
        do {
            try await registerTakeSchedule(week: week, medicineName: medicineName, memberName: memberName, time: time, takeAmount: takeAmount)
        } catch {
            print("Error: \(error)")
        }
    }
    
    // 약 일정 등록
    func registerTakeSchedule(week: [String], medicineName: String, memberName: String, time: [String], takeAmount: Int) async throws {
        var urlComponents = URLComponents()
        urlComponents.scheme = MediCheckAPI.scheme
        urlComponents.host = MediCheckAPI.host
        urlComponents.port = 80
        urlComponents.path = MediCheckAPI.Path.medicine_schedule.rawValue
        
        guard let url = urlComponents.url else {
            print("[registerTakeSchedule] Error: cannot create URL")
            throw ExchangeRateError.cannotCreateURL
        }
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        // JSON 데이터 추가
        
        let jsonString = """
        {
            "week": \(week),
            "medicineName": "\(medicineName)",
            "memberName": "\(memberName)",
            "time": \(time),
            "takeAmount": "\(takeAmount)"
        }
        """
        
        print(jsonString)
        if let jsonData = jsonString.data(using: .utf8) {
            body.append(jsonData)
        }
        
        request.httpBody = body
        
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print("[registerMedicine] \(data)")
        print("[registerMedicine] \(response)")
        
        guard let jsonString = String(data: data, encoding: .utf8) else {
            print("Error: Failed to convert data to string")
            throw ExchangeRateError.decodeFailed
        }
        print("[registerMedicine] \(jsonString)")
        
        if let response = response as? HTTPURLResponse,
           !(200..<300).contains(response.statusCode) {
            throw ExchangeRateError.badResponse
        }
    }
    
    @MainActor
    func fetchDeleteMedicine(medicineId: Int) async {
        do {
            try await deleteMedicine(medicineId: medicineId)
        } catch {
            print("Error: \(error)")
        }
    }
    
    // 등록된 약 삭제
    func deleteMedicine(medicineId: Int) async throws {
        var urlComponents = URLComponents()
        urlComponents.scheme = MediCheckAPI.scheme
        urlComponents.host = MediCheckAPI.host
        urlComponents.port = 80
        urlComponents.path = MediCheckAPI.Path.medicine_delete.rawValue
        urlComponents.queryItems = [URLQueryItem(name: "medicineId", value: String(medicineId))]
        print(medicineId)
        
        guard let url = urlComponents.url else {
            print("[deleteMedicine] Error: cannot create URL")
            throw ExchangeRateError.cannotCreateURL
        }
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print("[deleteMedicine] \(data)")
        print("[deleteMedicine] \(response)")
        
        guard let jsonString = String(data: data, encoding: .utf8) else {
            print("Error: Failed to convert data to string")
            throw ExchangeRateError.decodeFailed
        }
        print("[deleteMedicine] \(jsonString)")
        
        if let response = response as? HTTPURLResponse,
           !(200..<300).contains(response.statusCode) {
            throw ExchangeRateError.badResponse
        }
    }
    
    
    @MainActor
    func fetchMyMedicineData(memberName: String) async {
        do {
            medicines = try await getMyMedicineByMemberName(memberName: memberName)
        } catch {
            print("Error: \(error)")
        }
    }
    
    // 약 모두 조회 (사람 이름에 따라)
    func getMyMedicineByMemberName(memberName: String) async throws -> [MyMedicineDTO] {
        var urlComponents = URLComponents()
        urlComponents.scheme = MediCheckAPI.scheme
        urlComponents.host = MediCheckAPI.host
        urlComponents.port = 80
        urlComponents.path = MediCheckAPI.Path.medicine_check_take.rawValue
        urlComponents.queryItems = [URLQueryItem(name: "memberName", value: memberName)]
        
        guard let url = urlComponents.url else {
            print("[getMyMedicineByMemberName] Error: cannot create URL")
            throw ExchangeRateError.cannotCreateURL
        }
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        if let response = response as? HTTPURLResponse,
           !(200..<300).contains(response.statusCode) {
            throw ExchangeRateError.badResponse
        }
        
        print("[getMyMedicineByMemberName] \(data)")
        print("[getMyMedicineByMemberName] \(response)")
        
        guard let jsonString = String(data: data, encoding: .utf8) else {
            print("Error: Failed to convert data to string")
            throw ExchangeRateError.decodeFailed
        }
        print("[getMyMedicineByMemberName] \(jsonString)")
        
        let decoder = JSONDecoder()
        var medicines: [MyMedicineDTO] = []
        medicines = try decoder.decode([MyMedicineDTO].self, from: data)
        print("[getMyMedicineByMemberName] \(medicines)")
        
        return medicines
    }
    
//    @MainActor
//    func fetchMyScheduleData(memberName: String) async {
//        do {
//            schedules = try await getMyScheduleByMemberName(memberName: memberName)
//        } catch {
//            print("Error: \(error)")
//        }
//    }
//    
//    // 약 일정 모두 조회 (사람 이름에 따라)
//    func getMyScheduleByMemberName(memberName: String) async throws -> [MyScheduleDTO] {
//        var urlComponents = URLComponents()
//        urlComponents.scheme = MediCheckAPI.scheme
//        urlComponents.host = MediCheckAPI.host
//        urlComponents.port = 80
//        urlComponents.path = MediCheckAPI.Path.member_schedules.rawValue
//        urlComponents.queryItems = [URLQueryItem(name: "memberName", value: memberName)]
//        
//        guard let url = urlComponents.url else {
//            print("[getMyMedicineByMemberName] Error: cannot create URL")
//            throw ExchangeRateError.cannotCreateURL
//        }
//        print(url)
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        
//        let (data, response) = try await URLSession.shared.data(for: request)
//        if let response = response as? HTTPURLResponse,
//           !(200..<300).contains(response.statusCode) {
//            throw ExchangeRateError.badResponse
//        }
//        
//        print("[getMyMedicineByMemberName] \(data)")
//        print("[getMyMedicineByMemberName] \(response)")
//        
//        guard let jsonString = String(data: data, encoding: .utf8) else {
//            print("Error: Failed to convert data to string")
//            throw ExchangeRateError.decodeFailed
//        }
//        print("[getMyMedicineByMemberName] \(jsonString)")
//        
//        let decoder = JSONDecoder()
//        var medicines: [MyScheduleDTO] = []
//        medicines = try decoder.decode([MyScheduleDTO].self, from: data)
//        print("[getMyMedicineByMemberName] \(medicines)")
//        
//        return medicines
//    }
}

//extension RegisterScheduleViewModel {
//    struct TakeMedicineInfoDTO: Codable {
//        enum Week: String, Codable {
//            case MONDAY
//            case TUESDAY
//            case WEDNESDAY
//            case THURSDAY
//            case FRIDAY
//            case SATURDAY
//            case SUNDAY
//        }
//        let medicineName: String
//        let week: Week
//        let hour: Int
//        let minute: Int
//        let amount: Int
//    }
//}

extension RegisterScheduleViewModel {
    struct MyScheduleDTO: Codable {
        enum Week: String, Codable {
            case MONDAY
            case TUESDAY
            case WEDNESDAY
            case THURSDAY
            case FRIDAY
            case SATURDAY
            case SUNDAY
            case EVERYDAY
        }
        let medicineName: String
        let takeMedicineId: Int
        let week: Week
        let hour: Int
        let minute: Int
        let amounts: Int
    }
    
    struct MyMedicineDTO: Codable {
        let medicineId: Int
        let medicineName: String
        let information: String
        let makeDate: String
        let expirationDate: String
        let medicineContainer: Int
        let amounts: Int
        let imagUrl: String
        let takeMedicine: Bool
    }
}
