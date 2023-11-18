//
//  QRCodeViewModel.swift
//  SwiftUI-Study
//
//  Created by Kyungsoo Lee on 11/7/23.
//

import Foundation

fileprivate enum MediCheckAPI {
    static let scheme = "http"
    static let host = "yuno.hopto.org"
    
    enum Path: String {
        case medicine = "/medicine"
    }
}

class QRCodeViewModel: ObservableObject {
    @Published var medicine = Medicine()
    
    @MainActor
    func fetchData(medicineContainer: Int, medicineInfoJsonString: String) async {
        do {
            if let medicineInfoDictinoary = jsonStringToDictionary(jsonString: medicineInfoJsonString) {
                let name = medicineInfoDictinoary["name"] as? String ?? ""
                let makeDate = medicineInfoDictinoary["makeDate"] as? String ?? ""
                let expirationDate = medicineInfoDictinoary["expirationDate"] as? String ?? ""
                let amount = medicineInfoDictinoary["amount"] as? Int ?? 0
                let information = medicineInfoDictinoary["information"] as? String ?? ""
                let medicineCost = medicineInfoDictinoary["medicineCost"] as? Int ?? 0
                
                
                try await registerMedicine(name: name, makeDate: makeDate, expirationDate: expirationDate, amount: amount, information: information, medicineContainer: medicineContainer, medicineCost: medicineCost)
                medicine.name = name
                medicine.makeDate = makeDate
                medicine.expirationDate = expirationDate
                medicine.amount = amount
                medicine.information = information
                medicine.medicineContainer = medicineContainer
                medicine.medicineCost = medicineCost
            } else {
                print("Error")
                return
            }
            
        } catch {
            print("Error: \(error)")
        }
    }
    
    func jsonStringToDictionary(jsonString: String) -> [String: Any]? {
        // JSON 문자열을 Data로 변환
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                // JSONSerialization을 사용하여 Data를 Dictionary로 파싱
                if let jsonDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                    // 파싱된 Dictionary를 사용
                    if let name = jsonDictionary["name"] as? String {
                        print("Name: \(name)")
                    } else {
                        print("1")
                    }
                    if let makeDate = jsonDictionary["makeDate"] as? String {
                        print("Make Date: \(makeDate)")
                    } else {
                        print("2")
                    }
                    if let expirationDate = jsonDictionary["expirationDate"] as? String {
                        print("Expiration Date: \(expirationDate)")
                    } else {
                        print("3")
                    }
                    if let amount = jsonDictionary["amount"] as? Int {
                        print("Amount: \(amount)")
                    } else {
                        print("4")
                    }
                    if let information = jsonDictionary["information"] as? String {
                        print("Information: \(information)")
                    } else {
                        print("5")
                    }
                    if let medicineCost = jsonDictionary["medicineCost"] as? Int {
                        print("medicinCost: \(medicineCost)")
                    } else {
                        print("6")
                    }
                    return jsonDictionary
                } else {
                    print("Error: Failed to parse JSON as Dictionary")
                }
            } catch {
                print("Error: \(error)")
            }
        } else {
            print("Error: Failed to convert JSON string to Data")
        }
        return nil
    }
    
    func registerMedicine(name: String, makeDate: String, expirationDate: String, amount: Int, information: String, medicineContainer: Int, medicineCost: Int) async throws {
        var urlComponents = URLComponents()
        urlComponents.scheme = MediCheckAPI.scheme
        urlComponents.host = MediCheckAPI.host
        urlComponents.port = 80
        urlComponents.path = MediCheckAPI.Path.medicine.rawValue
        urlComponents.queryItems = [URLQueryItem(name: "medicineContainer", value: String(medicineContainer))]
        
        guard let url = urlComponents.url else {
            print("[registerMedicine] Error: cannot create URL")
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
            "name": "\(name)",
            "makeDate": "\(makeDate)",
            "expirationDate": "\(expirationDate)",
            "amount": "\(amount)",
            "information": "\(information)",
            "medicineCost": "\(medicineCost)"
        }
        """
        
        print(jsonString)
        if let jsonData = jsonString.data(using: .utf8) {
            body.append(jsonData)
        }
        
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        print("[registerMedicine] \(data)")
        print("[registerMedicine] \(response)")
        
        guard let jsonString = String(data: data, encoding: .utf8) else {
            print("Error: Failed to convert data to string")
            throw ExchangeRateError.decodeFailed
        }
        print("[registerMedicine] \(jsonString)")
        
        if let response = response as? HTTPURLResponse,
           !(200..<300).contains(response.statusCode) {
            throw ExchangeRateError.badResponse
        }
    }
    
}

