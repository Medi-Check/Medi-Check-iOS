//
//  RegistrationDrugView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/6/23.
//

import SwiftUI

struct RegistrationDrugView: View {
    var body: some View {
        GeometryReader { geometry in
            let geoWidth = geometry.size.width
            let geoHeight = geometry.size.height
            ZStack {
                SecondBackgroundView()
                VStack(spacing: 20) {
                    Button {
                        
                    } label: {
                        Image(systemName: "qrcode.viewfinder")
                            .resizable()
                            .padding(CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.05, landscapeIPhone: geoWidth * 0.03, portraitIPad: geoWidth * 0.05, landscapeIPad: geoWidth * 0.03))
                            .background(Color.gray)
                            .cornerRadius(30, corners: .allCorners)
                            .frame(width: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.5, landscapeIPhone: geoWidth * 0.3, portraitIPad: geoWidth * 0.5, landscapeIPad: geoWidth * 0.3), height: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.5, landscapeIPhone: geoWidth * 0.3, portraitIPad: geoWidth * 0.5, landscapeIPad: geoWidth * 0.3))
                            .foregroundStyle(Color.black)
                    }
                    
                    Text("약 정보 등록")
                        .font(.system(size: CGFloat.adaptiveSize(portraitIPhone: 20, landscapeIPhone: 20, portraitIPad: 40, landscapeIPad: 40), weight: .bold))
                }
            }
        }
    }
}

#Preview {
    RegistrationDrugView()
}
