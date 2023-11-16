//
//  SelectProfileViewModel.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/15/23.
//

import Foundation

fileprivate enum MediCheckAPI {
    static let scheme = "http"
    static let host = "yuno.hopto.org"
    
    enum Path: String {
        case members = "/members"
    }
    
}

class SelectProfileViewModel: ObservableObject {
    @Published var members: [getMembersDTO] = []
    
    @MainActor
    func fetchData(familyCode: String) async {
        do {
            self.members = try await getMembers(familyCode: familyCode)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func getMembers(familyCode: String) async throws -> [getMembersDTO] {
        var urlComponents = URLComponents()
        urlComponents.scheme = MediCheckAPI.scheme
        urlComponents.host = MediCheckAPI.host
        urlComponents.port = 80
        urlComponents.path = MediCheckAPI.Path.members.rawValue
        urlComponents.queryItems = [URLQueryItem(name: "familyCode", value: familyCode)]
        
        guard let url = urlComponents.url else {
            print("[getMembers] Error: cannot create URL")
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
        
        print(response)
        print(data)
        
        let decoder = JSONDecoder()
        var members: [getMembersDTO] = []
        members = try decoder.decode([getMembersDTO].self, from: data)
        
        return members
    }
    
    
    
}

extension SelectProfileViewModel {
    struct getMembersDTO: Codable {
        let nickName: String
        let imgUrl: String
    }
}
