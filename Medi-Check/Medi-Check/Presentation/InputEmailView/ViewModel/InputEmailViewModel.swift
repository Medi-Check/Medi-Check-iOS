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
        case email_FamilyCode = "/email/familyCode"
    }
    
}

class InputEmailViewModel: ObservableObject {
    @Published var member = Member()
    
    func sendFamilyCode(requestData: [String: Any]) {
        var urlComponents = URLComponents()
        urlComponents.scheme = MediCheckAPI.scheme
        urlComponents.host = MediCheckAPI.host
        urlComponents.port = 80
        urlComponents.path = MediCheckAPI.Path.email_FamilyCode.rawValue
        urlComponents.queryItems = [URLQueryItem(name: "email", value: requestData["email"] as? String)]
        
        guard let url = urlComponents.url else {
            print("[registerUser] Error: cannot create URL")
            return
        }
        print(url)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("[sendFamilyCode] Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("[sendFamilyCode] Error: Did not receive data")
                return
            }
            guard let jsonString = String(data: data, encoding: .utf8) else {
                print("[sendFamilyCode] Error: Failed to convert data to string")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("[sendFamilyCode] Error: HTTP request failed")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                do {
                    print(jsonString)
                } catch {
                    print("[sendFamilyCode] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    
    
}

extension InputEmailViewModel {
    struct sendFamilyCodeDTO {
        let familyCode: String
    }
}
