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
        case medicine_schedules = "/member/schedules"
    }
}

class RegisterScheduleViewModel: ObservableObject {
//    @Published var schdules: [TakeMedicineInfoDTO] = []
    @Published var medicines: [MyMedicineDTO] = []
    
    @MainActor
    func fetchData(week: String, medicineName: String, memberName: String, hour: Int, minute: Int, amounts: Int) async {
        do {
            try await registerTakeSchedule(week: week, medicineName: medicineName, memberName: memberName, hour: hour, minute: minute, amounts: amounts)
        } catch {
            print("Error: \(error)")
        }
    }
    
    // 약 일정 등록
    func registerTakeSchedule(week: String, medicineName: String, memberName: String, hour: Int, minute: Int, amounts: Int) async throws {
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
            "week": "\(week)",
            "medicineName": "\(medicineName)",
            "memberName": "\(memberName)",
            "hour": "\(hour)",
            "minute": "\(minute)",
            "amounts": "\(amounts)"
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
    func fetchMyMedicinesData(memberName: String) async {
        do {
            medicines = try await getMyMedicineByMemberName(memberName: memberName)
        } catch {
            print("Error: \(error)")
        }
    }
    
    // 약 일정 모두 조회 (사람 이름에 따라)
    func getMyMedicineByMemberName(memberName: String) async throws -> [MyMedicineDTO] {
        var urlComponents = URLComponents()
        urlComponents.scheme = MediCheckAPI.scheme
        urlComponents.host = MediCheckAPI.host
        urlComponents.port = 80
        urlComponents.path = MediCheckAPI.Path.medicine_schedules.rawValue
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
        
        return medicines
    }
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
    struct MyMedicineDTO: Codable {
        enum Week: String, Codable {
            case MONDAY
            case TUESDAY
            case WEDNESDAY
            case THURSDAY
            case FRIDAY
            case SATURDAY
            case SUNDAY
        }
        let medicineName: String
        let takeMedicineId: Int
        let week: Week
        let hour: Int
        let minute: Int
        let amounts: Int
    }
}
