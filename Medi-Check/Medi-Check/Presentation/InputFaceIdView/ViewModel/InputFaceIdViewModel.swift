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
    
    @MainActor
    func fetchData(requestData: [String: Any]) async {
        do {
            member.nickname = try await registerUserAPI(requestData: requestData).nickName
            print(member)
        } catch {
            print("Error: \(error)")
            
        }
    }
    
    func registerUserAPI(requestData: [String: Any]) async throws -> RegisterUserDTO {
        var urlComponents = URLComponents()
        urlComponents.scheme = MediCheckAPI.scheme
        urlComponents.host = MediCheckAPI.host
        urlComponents.port = 80
        urlComponents.path = MediCheckAPI.Path.member_nickname.rawValue
        
        guard let url = urlComponents.url else {
            print("[registerUser] Error: cannot create URL")
            throw ExchangeRateError.cannotCreateURL
        }
        print(url)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        print(data)
        print(response)
        
        guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
            print("Error: convert failed json to dictionary")
            throw ExchangeRateError.decodeFailed
        }
        print(jsonDictionary)
        if let response = response as? HTTPURLResponse,
           !(200..<300).contains(response.statusCode) {
            throw ExchangeRateError.badResponse
        }
        let decoder = JSONDecoder()
        var registerUserDTO = try decoder.decode(RegisterUserDTO.self, from: data)
        return registerUserDTO
    }
}

extension InputFaceIdViewModel {
    struct RegisterUserDTO: Decodable {
        let nickName: String
        let familyCode: String
    }
}
