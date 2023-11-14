//
//  InputEmailViewModel.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/13/23.
//

import Foundation

fileprivate enum MediCheckAPI {
    static let scheme = "http"
    static let host = "yuno.hopto.org"
    
    enum Path: String {
        case email_familyCode = "/email/familyCode"
    }
    
}

enum ExchangeRateError: Error {
    case badResponse
    case decodeFailed
    case cannotCreateURL
}

class InputEmailViewModel: ObservableObject {
    @Published var member = Member()
    
    func fetchData(requestData: [String: Any], completion: @escaping () -> Void) {
        Task {
            do {
                member.familyCode = try await sendFamilyCodeAPI(requestData: requestData)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func sendFamilyCodeAPI(requestData: [String: Any]) async throws -> String {
        var urlComponents = URLComponents()
        urlComponents.scheme = MediCheckAPI.scheme
        urlComponents.host = MediCheckAPI.host
        urlComponents.port = 80
        urlComponents.path = MediCheckAPI.Path.email_familyCode.rawValue
        urlComponents.queryItems = [URLQueryItem(name: "email", value: requestData["email"] as? String)]
        
        guard let url = urlComponents.url else {
            print("[sendFamilyCode] Error: cannot create URL")
            throw ExchangeRateError.cannotCreateURL
        }
        print(url)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        if let response = response as? HTTPURLResponse,
           !(200..<300).contains(response.statusCode) {
            throw ExchangeRateError.badResponse
        }
        guard let familyCode = String(data: data, encoding: .utf8) else {
            throw ExchangeRateError.decodeFailed
        }
        return familyCode
    }
    
    
    
}

extension InputEmailViewModel {
    
    struct SendFamilyCodeDTO: Codable {
        let familyCode: String
    }
}
