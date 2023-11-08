//
//  QRCodeViewModel.swift
//  SwiftUI-Study
//
//  Created by Kyungsoo Lee on 11/7/23.
//

import Foundation

class QRCodeViewModel: ObservableObject {
    @Published var jsonFile: String = ""
    
//    // HTML 문자열에서 JSON 부분을 추출하는 함수
//    func extractJSON(fromHTML html: String) -> String? {
//        // 정규 표현식 패턴을 조정하여 실제 HTML 콘텐츠에 맞게 수정합니다.
//        // 이 패턴은 간단한 예제로, 실제 상황에서는 다를 수 있습니다.
//        let pattern = "\\{<br>&nbsp; &nbsp;\"[^\"]*\" : \"[^\"]*\",<br>(?:&nbsp; &nbsp;\"[^\"]*\" : \"[^\"]*\",<br>)*&nbsp; &nbsp;\"[^\"]*\" : \"[^\"]*\"<br>\\}"
//        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
//            let nsrange = NSRange(html.startIndex..<html.endIndex, in: html)
//            if let match = regex.firstMatch(in: html, options: [], range: nsrange) {
//                let matchedString = String(html[Range(match.range, in: html)!])
//                // HTML 태그와 특수 문자를 JSON 형식에 맞게 치환합니다.
//                let json = matchedString
//                    .replacingOccurrences(of: "<br>", with: "")
//                    .replacingOccurrences(of: "&nbsp;", with: " ")
//                return json
//            }
//        }
//        return nil
//    }
    
    func getJsonFile(urlString: String) {
        guard let urlComponents = URLComponents(string: urlString) else {
            return
        }
        
        print("QRCodeViewModel : \(urlComponents)")
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
//
//            guard let jsonString = String(data: data, encoding: .utf8) else {
//                print("Error: Failed to convert data to string")
//                return
//            }
//            print(jsonString)
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
                print("Error: convert failed json to dictionary")
                return
            }
            print(jsonDictionary)
            
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            DispatchQueue.main.async { [weak self] in
                do {
                } catch {
                    print("[createStory] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
}
