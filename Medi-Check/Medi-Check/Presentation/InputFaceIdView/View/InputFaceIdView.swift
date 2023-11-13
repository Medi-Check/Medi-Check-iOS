//
//  InputFaceIdView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/7/23.
//

import SwiftUI

struct InputFaceIdView: View {
    @Binding var isInputNicknameViewPresented: Bool
    @Binding var nickname: String
    @EnvironmentObject var viewModel: InputFaceIdViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let geoWidth = geometry.size.width
            let geoHeight = geometry.size.height
            ZStack {
                FirstBackgroundView()
                VStack {
                    Text("사용자의 얼굴을 인식합니다.\n화면을 응시해주세요.")
                        .font(.system(size: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.08, landscapeIPhone: geoWidth * 0.04, portraitIPad: geoWidth * 0.05, landscapeIPad: geoWidth * 0.05), weight: .bold))
                        .padding(EdgeInsets(top: geoHeight * 0.2, leading: 0, bottom: geoHeight * 0.15, trailing: 0))
                    
                        
                        Rectangle()
                            .frame(width: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.3, landscapeIPhone: geoWidth * 0.3, portraitIPad: geoWidth * 0.3, landscapeIPad: geoWidth * 0.3), height: CGFloat.adaptiveSize(portraitIPhone: geoHeight * 0.2, landscapeIPhone: geoHeight * 0.5, portraitIPad: geoHeight * 0.25, landscapeIPad: geoHeight * 0.4))
                            .foregroundStyle(Color.gray)
                    
                    Spacer()
                    
                    Button {
//                        viewModel.registerUser(requestData: <#T##[String : Any]#>)
                        isInputNicknameViewPresented = false
                    } label: {
                        BasicButtonLabel(text: "완료", strokeWidth: 1, fontSize: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.1, landscapeIPhone: geoWidth * 0.05, portraitIPad: geoWidth * 0.07, landscapeIPad: geoWidth * 0.05), width: geoWidth, height: geoHeight * 0.07)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                            .background(Color.MediCheckMainColor)
                    }
                }
            }
        }
        .onTapGesture {
            self.endTextEditing()
        }
    }
}

#Preview {
    InputFaceIdView(isInputNicknameViewPresented: .constant(false), nickname: .constant("kyxxgsoo"))
        .environmentObject(InputFaceIdViewModel())
}
