//
//  InputFaceIdViewModel.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/14/23.
//
import Foundation

fileprivate enum MediCheckAPI {
    static let scheme = "http"
    static let host = "yuno.hopto.org"
    
    enum Path: String {
        case member_nickname = "/member/nickname"
    }
    
}

class InputFaceIdViewModel: ObservableObject {
    @Published var member = Member()
    
    func registerUser(requestData: [String: Any]) {
        var urlComponents = URLComponents()
        urlComponents.scheme = MediCheckAPI.scheme
        urlComponents.host = MediCheckAPI.host
        urlComponents.port = 80
        urlComponents.path = MediCheckAPI.Path.member_nickname.rawValue
        
        guard let url = urlComponents.url else {
            print("[registerUser] Error: cannot create URL")
            return
        }
        print(url)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("[registerUser] Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("[registerUser] Error: Did not receive data")
                return
            }
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
                print("Error: convert failed json to dictionary")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("[registerUser] Error: HTTP request failed")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                do {
                    print(jsonDictionary)
                } catch {
                    print("[registerUser] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    
    
}

extension InputFaceIdViewModel {
    struct registerUserDTO {
        let nickName: String
        let familyCode: String
    }
}
