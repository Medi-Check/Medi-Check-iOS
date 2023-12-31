//
//  QRCodeView.swift
//  SwiftUI-Study
//
//  Created by Kyungsoo Lee on 11/7/23.
//

import SwiftUI
import CarBode
import AVFoundation //import to access barcode types you want to scan

struct TestModel: Decodable {
    var name: String
    var make: String
    var amount: String
    var information: String
}

struct QRCodeView: View {
    @State var qrCodeValue: String = ""
    @ObservedObject var viewModel = QRCodeViewModel()
    @Binding var goToQRCodeView: Bool
    
    var body: some View {
        VStack{
            
            CBScanner(
                supportBarcode: .constant([.qr, .code128]), //Set type of barcode you want to scan
                scanInterval: .constant(5.0) //Event will trigger every 5 seconds
            ){
                //When the scanner found a barcode
                print("BarCodeType =",$0.type.rawValue, "Value =",$0.value)
                qrCodeValue = $0.value
                if qrCodeValue != "" {
                    Task {
                        await viewModel.fetchData(medicineContainer: 1, medicineInfoJsonString: qrCodeValue)
                    }
                    goToQRCodeView = false
                }
            }
            
        }
    }
}

//#Preview {
//    QRCodeView(isQRCodeViewPresented: .constant(false))
//}
