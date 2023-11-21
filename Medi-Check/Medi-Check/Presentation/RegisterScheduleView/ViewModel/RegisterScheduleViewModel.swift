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
        case medicine_container = "/medicine/container"
    }
}

class RegisterScheduleViewModel: ObservableObject {
    @Published var schedules: [MyScheduleDTO] = []
    @Published var medicines: [MyMedicineDTO] = []
    @Published var containerStatus: [Bool] = [false, false, false, false]
    @Published var container: ContainerStatus = ContainerStatus(first: false, second: false, third: false, fourth: false)
    
    @MainActor
    func fetchData(week: [String], medicineName: String, memberName: String, time: [String], takeAmount: Int) async {
        do {
            try await registerTakeSchedule(week: week, medicineName: medicineName, memberName: memberName, time: time, takeAmount: takeAmount)
        } catch {
            print("[fetchData] Error: \(error)")
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
    func fetchRegisterContainer(medicineId: Int, containerId: Int) async {
        do {
            try await registerContainer(medicineId: medicineId, containerId: containerId)
        } catch {
            print("[registerContainer] Error: \(error)")
        }
    }
    
    // 약통 등록
    func registerContainer(medicineId: Int, containerId: Int) async throws {
        var urlComponents = URLComponents()
        urlComponents.scheme = MediCheckAPI.scheme
        urlComponents.host = MediCheckAPI.host
        urlComponents.port = 80
        urlComponents.path = MediCheckAPI.Path.medicine_container.rawValue
        let queryItem1 = URLQueryItem(name: "medicineId", value: "\(medicineId)")
        let queryItem2 = URLQueryItem(name: "containerId", value: "\(containerId)")
        urlComponents.queryItems = [queryItem1, queryItem2]
        
        print("logloglog \(medicineId), \(containerId)")
        
        guard let url = urlComponents.url else {
            print("[registerContainer] Error: cannot create URL")
            throw ExchangeRateError.cannotCreateURL
        }
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print("[registerContainer] \(data)")
        print("[registerContainer] \(response)")
        
        guard let jsonString = String(data: data, encoding: .utf8) else {
            print("Error: Failed to convert data to string")
            throw ExchangeRateError.decodeFailed
        }
        print("[registerContainer] \(jsonString)")
        
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
            print("[fetchDeleteMedicine] Error: \(error)")
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
            print("[fetchMyMedicineData] Error: \(error)")
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
    
    @MainActor
    func fetchContainerStatus() async {
        do {
            container = try await getContainerStatus()
            containerStatus[0] = container.first
            containerStatus[1] = container.second
            containerStatus[2] = container.third
            containerStatus[3] = container.fourth
        } catch {
            print("[getContainerStatus] Error: \(error)")
        }
    }
    
    // 컨테이너 조회
    func getContainerStatus() async throws -> ContainerStatus {
        var urlComponents = URLComponents()
        urlComponents.scheme = MediCheckAPI.scheme
        urlComponents.host = MediCheckAPI.host
        urlComponents.port = 80
        urlComponents.path = MediCheckAPI.Path.medicine_container.rawValue
        
        guard let url = urlComponents.url else {
            print("[getContainerStatus] Error: cannot create URL")
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
        
        print("[getContainerStatus] \(data)")
        print("[getContainerStatus] \(response)")
        
        guard let jsonString = String(data: data, encoding: .utf8) else {
            print("Error: Failed to convert data to string")
            throw ExchangeRateError.decodeFailed
        }
        print("[getContainerStatus] \(jsonString)")
        
        let decoder = JSONDecoder()
        var container: ContainerStatus
        container = try decoder.decode(ContainerStatus.self, from: data)
        print("[getContainerStatus] \(medicines)")
        
        return container
    }
}

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
    
    struct ContainerStatus: Codable {
        let first: Bool
        let second: Bool
        let third: Bool
        let fourth: Bool
    }
}
