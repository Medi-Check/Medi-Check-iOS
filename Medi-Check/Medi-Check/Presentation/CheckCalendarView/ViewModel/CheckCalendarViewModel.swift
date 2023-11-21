//
//  CheckCalendarViewModel.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/15/23.
//

import Foundation

fileprivate enum MediCheckAPI {
    static let scheme = "http"
    static let host = "yuno.hopto.org"
    
    enum Path: String {
        case member_scheduels = "/member/schedules"
        case medicine_take_false = "/medicine/take/false"
    }
}

class CheckCalendarViewModel: ObservableObject {
    @Published var schedules: [getScheduleDTO] = []
    
    
    @MainActor
    func fetchSchedulesForMemberName(memberName: String) async {
        do {
            self.schedules = try await getSchedulesForMemberName(memberName: memberName)
            print(schedules)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func getSchedulesForMemberName(memberName: String) async throws -> [getScheduleDTO] {
        var urlComponents = URLComponents()
        urlComponents.scheme = MediCheckAPI.scheme
        urlComponents.host = MediCheckAPI.host
        urlComponents.port = 80
        urlComponents.path = MediCheckAPI.Path.member_scheduels.rawValue
        urlComponents.queryItems = [URLQueryItem(name: "memberName", value: String(memberName))]
        
        
        guard let url = urlComponents.url else {
            print("[getSchedulesForMemberName] Error: cannot create URL")
            throw ExchangeRateError.cannotCreateURL
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        print("[getSchedulesForMemberName] \(data)")
        print("[getSchedulesForMemberName] \(response)")
        
        guard let jsonString = String(data: data, encoding: .utf8) else {
            print("Error: Failed to convert data to string")
            throw ExchangeRateError.decodeFailed
        }
        print("[getSchedulesForMemberName] \(jsonString)")
        
        if let response = response as? HTTPURLResponse,
           !(200..<300).contains(response.statusCode) {
            throw ExchangeRateError.badResponse
        }
        
        let decoder = JSONDecoder()
        var schedules: [getScheduleDTO] = []
        schedules = try decoder.decode([getScheduleDTO].self, from: data)
        
        return schedules
    }
    
    @MainActor
    func changeHStackColor(takeMedicineId: Int) async {
        do {
            try await turnOffGreenScreen(takeMedicineId: takeMedicineId)
        } catch {
            print("Error: \(error)")
        }
    }
    
    // 약 복용 체크(By ID)
    func turnOffGreenScreen(takeMedicineId: Int) async throws {
        var urlComponents = URLComponents()
        urlComponents.scheme = MediCheckAPI.scheme
        urlComponents.host = MediCheckAPI.host
        urlComponents.port = 80
        urlComponents.path = MediCheckAPI.Path.medicine_take_false.rawValue
        urlComponents.queryItems = [URLQueryItem(name: "takeMedicineId", value: "\(takeMedicineId)")]
        
        guard let url = urlComponents.url else {
            print("[turnOffLED] Error: cannot create URL")
            throw ExchangeRateError.cannotCreateURL
        }
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
//        var body = Data()
//        
//        // JSON 데이터 추가
//        
//        let jsonString = """
//        {
//            "takeMedicineId": \(takeMedicineId),
//            "checked": "\(checked)"
//        }
//        """
//        
//        print(jsonString)
//        if let jsonData = jsonString.data(using: .utf8) {
//            body.append(jsonData)
//        }
//        
//        request.httpBody = body
        
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print("[turnOffLED] \(data)")
        print("[turnOffLED] \(response)")
        
        guard let jsonString = String(data: data, encoding: .utf8) else {
            print("Error: Failed to convert data to string")
            throw ExchangeRateError.decodeFailed
        }
        print("[turnOffLED] \(jsonString)")
        
        if let response = response as? HTTPURLResponse,
           !(200..<300).contains(response.statusCode) {
            throw ExchangeRateError.badResponse
        }
    }
    
    
}

extension CheckCalendarViewModel {
    struct getScheduleDTO: Codable, Identifiable {
        let id: Int?
        let medicineName: String
        let takeMedicineId: Int
        let week: String
        let hour: Int
        let minute: Int
        let amounts: Int
        let medicineImgUrl: String
        let status: Bool
    }
}
