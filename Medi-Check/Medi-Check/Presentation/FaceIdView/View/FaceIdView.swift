//
//  FaceIdView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/6/23.
//

import SwiftUI

struct FaceIdView: View {
    @State private var isSelectProfileViewPresented: Bool = false
    var body: some View {
        GeometryReader { geometry in
            let geoWidth = geometry.size.width
            let geoHeight = geometry.size.height
            ZStack {
                SecondBackgroundView()
                VStack {
                    Text("얼굴을 인식합니다.")
                        .font(.system(size: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.08, landscapeIPhone: geoWidth * 0.04, portraitIPad: geoWidth * 0.07, landscapeIPad: geoWidth * 0.05), weight: .bold))
                        .padding(EdgeInsets(top: geoHeight * 0.1, leading: 0, bottom: 0, trailing: 0))
                    
                    Rectangle()
                        .cornerRadius(15, corners: .allCorners)
                        .frame(width: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.6, landscapeIPhone: geoWidth * 0.5, portraitIPad: geoWidth * 0.5, landscapeIPad: geoWidth * 0.5), height: CGFloat.adaptiveSize(portraitIPhone: geoHeight * 0.5, landscapeIPhone: geoHeight * 0.5, portraitIPad: geoHeight * 0.5, landscapeIPad: geoHeight * 0.5))
                        .foregroundStyle(.gray)
                    Button {
                        isSelectProfileViewPresented = true
                    } label: {
                        BasicButtonLabel(text: "프로필 선택", strokeWidth: 1, 
                                         fontSize: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.1, landscapeIPhone: geoWidth * 0.05, portraitIPad: geoWidth * 0.07, landscapeIPad: geoWidth * 0.05),
                                         width: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.6, landscapeIPhone: geoWidth * 0.5, portraitIPad: geoWidth * 0.5, landscapeIPad: geoWidth * 0.5),
                                         height: CGFloat.adaptiveSize(portraitIPhone: geoHeight * 0.07, landscapeIPhone: geoHeight * 0.07, portraitIPad: geoHeight * 0.07, landscapeIPad: geoHeight * 0.07))
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                            .background(Color.MediCheckMainColor)
                            .cornerRadius(15, corners: .allCorners)
                    }
                    .navigationDestination(isPresented: $isSelectProfileViewPresented) {
                        SelectProfileView()
                    }
                }
            }
        }
    }
}

#Preview {
    FaceIdView()
}
