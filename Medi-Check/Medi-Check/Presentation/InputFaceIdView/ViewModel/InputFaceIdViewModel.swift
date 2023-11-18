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
    func fetchData(imageData: Data?, requestDictionary: [String: Any]) async {
        do {
            let nickName = requestDictionary["nickName"] as! String
            let familyCode = requestDictionary["familyCode"] as! String
            try await registerUser(imageData: imageData, nickName: nickName, familyCode: familyCode)
            member.nickName = nickName
            member.familyCode = familyCode
            print(member)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func registerUser(imageData: Data?, nickName: String, familyCode: String) async throws {
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
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        // 이미지 추가
        if let imageData = imageData {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"images\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        // JSON 데이터 추가
        let jsonPart = """
        {
            "nickName": "\(nickName)",
            "familyCode": "\(familyCode)"
        }
        """
        if let jsonData = jsonPart.data(using: .utf8) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"memberInfo\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
            body.append(jsonData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        print("[registerUserAPI] \(data)")
        print("[registerUserAPI] \(response)")
        
        guard let jsonString = String(data: data, encoding: .utf8) else {
            print("Error: Failed to convert data to string")
            throw ExchangeRateError.decodeFailed
        }
        print("[registerUserAPI] \(jsonString)")
        
        if let response = response as? HTTPURLResponse,
           !(200..<300).contains(response.statusCode) {
            throw ExchangeRateError.badResponse
        }
    }
    
}

