//
//  QRCodeViewModel.swift
//  SwiftUI-Study
//
//  Created by Kyungsoo Lee on 11/7/23.
//

import Foundation

class QRCodeViewModel: ObservableObject {
    @Published var jsonFile: String = ""
    
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
