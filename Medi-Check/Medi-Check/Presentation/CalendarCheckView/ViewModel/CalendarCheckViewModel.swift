//
//  CalendarCheckViewModel.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/15/23.
//

import Foundation

fileprivate enum MediCheckAPI {
    static let scheme = "http"
    static let host = "yuno.hopto.org"
    
    enum Path: String {
        case medicine_schedules = "/medicine/schedules"
    }
}

class CalendarCheckViewModel: ObservableObject {
    @Published var schedules: [getScheduleDTO] = []
    
    @MainActor
    func fetchData(memberName: String) async {
        do {
            self.schedules = try await getSchedules(memberName: memberName)
            print(schedules)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func getSchedules(memberName: String) async throws -> [getScheduleDTO] {
        var urlComponents = URLComponents()
        urlComponents.scheme = MediCheckAPI.scheme
        urlComponents.host = MediCheckAPI.host
        urlComponents.port = 80
        urlComponents.path = MediCheckAPI.Path.medicine_schedules.rawValue
        urlComponents.queryItems = [URLQueryItem(name: "memberName", value: String(memberName))]
        
        guard let url = urlComponents.url else {
            print("[getSchedules] Error: cannot create URL")
            throw ExchangeRateError.cannotCreateURL
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        print("[getSchedules] \(data)")
        print("[getSchedules] \(response)")
        
        guard let jsonString = String(data: data, encoding: .utf8) else {
            print("Error: Failed to convert data to string")
            throw ExchangeRateError.decodeFailed
        }
        print("[getSchedules] \(jsonString)")
        
        if let response = response as? HTTPURLResponse,
           !(200..<300).contains(response.statusCode) {
            throw ExchangeRateError.badResponse
        }
        
        let decoder = JSONDecoder()
        var schedules: [getScheduleDTO] = []
        schedules = try decoder.decode([getScheduleDTO].self, from: data)
        
        return schedules
    }
}

extension CalendarCheckViewModel {
    struct getScheduleDTO: Codable {
        let medicineName: String
        let week: String
        let hour: Int
        let minute: Int
        let amounts: Int
    }
}
