//
//  FaceIdView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/6/23.
//

import SwiftUI

struct FaceIdView: View {
    @State private var isSuccessFaceId = false
    @State private var goToSelectProfileView = false
    @Binding var goToFaceIdView: Bool
    
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
                    
                    // VideoContentView에서 얼굴인식하면 자동으로 바로 이전 뷰로 돌아가는 현상이 있음... 임시로 goToFaceIdView를 바인딩해서 처리해놨지만 해결해야함.
                    VideoContentView(goToSelectProfileView: $goToSelectProfileView, isSuccessFaceId: $isSuccessFaceId, nickname: .constant(""))
                        .cornerRadius(15, corners: .allCorners)
                        .frame(height: CGFloat.adaptiveSize(portraitIPhone: geoHeight * 0.5, landscapeIPhone: geoHeight * 0.5, portraitIPad: geoHeight * 0.7, landscapeIPad: geoHeight * 0.65))
                        .foregroundStyle(.black)
                        .navigationDestination(isPresented: $isSuccessFaceId) {
                            HomeView()
                        }
                    
                    Button {
                        goToSelectProfileView = true
                    } label: {
                        BasicButtonLabel(text: "프로필 선택", strokeWidth: 1,
                                         fontSize: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.1, landscapeIPhone: geoWidth * 0.05, portraitIPad: geoWidth * 0.07, landscapeIPad: geoWidth * 0.05),
                                         width: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.6, landscapeIPhone: geoWidth * 0.5, portraitIPad: geoWidth * 0.5, landscapeIPad: geoWidth * 0.5),
                                         height: CGFloat.adaptiveSize(portraitIPhone: geoHeight * 0.07, landscapeIPhone: geoHeight * 0.07, portraitIPad: geoHeight * 0.07, landscapeIPad: geoHeight * 0.07))
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                            .background(Color.MediCheckMainColor)
                            .cornerRadius(15, corners: .allCorners)
                    }
                    .navigationDestination(isPresented: $goToSelectProfileView) {
                        SelectProfileView(goToSelectProfileView: $goToSelectProfileView)
                    }
                    
                }
            }
        }
    }
}

//#Preview {
//    FaceIdView(isFaceIdViewPresented: .constant(false))
//}
