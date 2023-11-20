//
//  MedicineSheetViewModel.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/21/23.
//

import Foundation

class MedicineSheetViewModel: ObservableObject {
    
    fileprivate enum MediCheckAPI {
        static let scheme = "http"
        static let host = "yuno.hopto.org"
        
        enum Path: String {
            case medicine_eat = "/medicine/eat"
        }
    }
    
    @MainActor
    func fetchData(takeMedicineId: Int, checked: Int) async {
        do {
            try await checkTakeMedicineById(takeMedicineId: takeMedicineId, checked: checked)
        } catch {
            print("Error: \(error)")
        }
    }
    
    // 약 복용 체크(By ID)
    func checkTakeMedicineById(takeMedicineId: Int, checked: Int) async throws {
        var urlComponents = URLComponents()
        urlComponents.scheme = MediCheckAPI.scheme
        urlComponents.host = MediCheckAPI.host
        urlComponents.port = 80
        urlComponents.path = MediCheckAPI.Path.medicine_eat.rawValue
        
        guard let url = urlComponents.url else {
            print("[checkTakeMedicineById] Error: cannot create URL")
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
            "takeMedicineId": \(takeMedicineId),
            "checked": "\(checked)"
        }
        """
        
        print(jsonString)
        if let jsonData = jsonString.data(using: .utf8) {
            body.append(jsonData)
        }
        
        request.httpBody = body
        
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print("[checkTakeMedicineById] \(data)")
        print("[checkTakeMedicineById] \(response)")
        
        guard let jsonString = String(data: data, encoding: .utf8) else {
            print("Error: Failed to convert data to string")
            throw ExchangeRateError.decodeFailed
        }
        print("[checkTakeMedicineById] \(jsonString)")
        
        if let response = response as? HTTPURLResponse,
           !(200..<300).contains(response.statusCode) {
            throw ExchangeRateError.badResponse
        }
    }
}
