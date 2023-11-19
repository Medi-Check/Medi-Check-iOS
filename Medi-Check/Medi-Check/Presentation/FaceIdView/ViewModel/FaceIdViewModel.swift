//
//  FaceIdViewModel.swift
//  Aespa-iOS
//
//  Created by Kyungsoo Lee on 11/18/23.
//

import Foundation

class FaceIdViewModel: ObservableObject {
    
    func uploadImage(imageData: Data, to serverURL: URL, completion: @escaping (Result<Bool, Error>) -> Void) {
        var request = URLRequest(url: serverURL)
        request.httpMethod = "POST"

        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"img\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body

        URLSession.shared.dataTask(with: request) { data, response, error in
            print("data : \(data)")
            print("response : \(response)")
            print("error : \(error)")
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let jsonString = String(data: data!, encoding: .utf8) else {
                print("Error: Failed to convert data to string")
                return
            }
            print("jsonString : \(jsonString)")
            completion(.success(true))
        }.resume()
    }

    
    
    func uploadVideo(videoData: Data, to serverURL: URL, completion: @escaping (Result<Bool, Error>) -> Void) {
        // 1. 요청을 생성합니다.
        var request = URLRequest(url: serverURL)
        request.httpMethod = "POST"
        
        // 2. 멀티파트 형식을 위한 경계 문자열을 생성합니다.
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // 3. HTTP 바디를 구성합니다.
        var body = Data()
        let filename = "video.mp4"
        let mimeType = "video/mp4"
        
        // 4. 비디오 데이터를 멀티파트 형식으로 추가합니다.
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"video\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        body.append(videoData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        // 5. 요청에 바디를 추가합니다.
        request.httpBody = body
        
        // 6. 요청을 전송합니다.
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("data : \(data)")
            print("response : \(response)")
            print("error : \(error)")
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let jsonString = String(data: data!, encoding: .utf8) else {
                print("Error: Failed to convert data to string")
                return
            }
            print("jsonString : \(jsonString)")
            completion(.success(true))
        }.resume()
    }
    
    func uploadVideo1(videoURL: URL, to serverURL: URL, completion: @escaping (Result<Bool, Error>) -> Void) {
        var request = URLRequest(url: serverURL)
        request.httpMethod = "POST"

        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"video\"; filename=\"\(videoURL.lastPathComponent)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: video/mp4\r\n\r\n".data(using: .utf8)!)
        body.append(try! Data(contentsOf: videoURL))
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body

        URLSession.shared.dataTask(with: request) { data, response, error in
            print("data : \(data)")
            print("response : \(response)")
            print("error : \(error)")
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let jsonString = String(data: data!, encoding: .utf8) else {
                print("Error: Failed to convert data to string")
                return
            }
            print("jsonString : \(jsonString)")
            completion(.success(true))
        }.resume()
    }

    func uploadVideo2(at filePath: String, to serverURL: URL, completion: @escaping (Result<Bool, Error>) -> Void) {
        let videoURL = URL(fileURLWithPath: filePath)

        // 1. URLRequest 생성
        var request = URLRequest(url: serverURL)
        request.httpMethod = "POST"

        // 2. 멀티파트 바운더리 생성
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        // 3. HTTP 바디 구성
        var body = Data()

        // 4. 비디오 파일 데이터 추가
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"video\"; filename=\"\(videoURL.lastPathComponent)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: video/mp4\r\n\r\n".data(using: .utf8)!)
        do {
            let videoData = try Data(contentsOf: videoURL)
            body.append(videoData)
        } catch {
            completion(.failure(error))
            return
        }
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        // 5. 요청에 바디 설정
        request.httpBody = body

        // 6. 요청 전송
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("data : \(data)")
            print("response : \(response)")
            print("error : \(error)")
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let jsonString = String(data: data!, encoding: .utf8) else {
                print("Error: Failed to convert data to string")
                return
            }
            print("jsonString : \(jsonString)")
            completion(.success(true))
        }.resume()
    }
    
    
}

extension Data {
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}
