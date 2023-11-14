//
//  InputNicknameView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/7/23.
//

import SwiftUI

struct InputNicknameView: View {
    @State private var nickname: String = ""
    @State var isInputFaceIdViewPresented: Bool = false
    @Binding var isInputNicknameViewPresented: Bool
    var body: some View {
        GeometryReader { geometry in
            let geoWidth = geometry.size.width
            let geoHeight = geometry.size.height
            ZStack {
                FirstBackgroundView()
                VStack {
                    Text("메디체크에서 사용할\n닉네임을 입력해주세요.")
                        .font(.system(size: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.08, landscapeIPhone: geoWidth * 0.04, portraitIPad: geoWidth * 0.05, landscapeIPad: geoWidth * 0.05), weight: .bold))
                        .padding(EdgeInsets(top: geoHeight * 0.2, leading: 0, bottom: geoHeight * 0.15, trailing: 0))
                    
                    VStack(alignment: .leading) {
                        Text("닉네임")
                            .font(.system(size: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.05, landscapeIPhone: geoWidth * 0.03, portraitIPad: geoWidth * 0.02, landscapeIPad: geoWidth * 0.02), weight: .bold))
                            .foregroundStyle(Color.gray)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: geoHeight * 0.05, trailing: 0))
                        
                        TextField("숫자, 특수문자, 이모티콘 모두 사용 가능", text: $nickname)
                            .font(.system(size: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.06, landscapeIPhone: geoWidth * 0.04, portraitIPad: geoWidth * 0.025, landscapeIPad: geoWidth * 0.025), weight: .bold))
                        
                        Rectangle()
                            .frame(height: 1.5)
                    }
                    .frame(width: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.85, landscapeIPhone: geoWidth * 0.63, portraitIPad: geoWidth * 0.5, landscapeIPad: geoWidth * 0.5), alignment: .leading)
                    .foregroundStyle(Color.gray)
                    
                    Spacer()
                    Button {
                        isInputFaceIdViewPresented = true
                    } label: {
                        BasicButtonLabel(text: "완료", strokeWidth: 1, fontSize: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.1, landscapeIPhone: geoWidth * 0.05, portraitIPad: geoWidth * 0.07, landscapeIPad: geoWidth * 0.05), width: geoWidth, height: geoHeight * 0.07)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                            .background(Color.MediCheckMainColor)
                    }
                    .navigationDestination(isPresented: $isInputFaceIdViewPresented) {
                        InputFaceIdView(isInputNicknameViewPresented: $isInputNicknameViewPresented, nickname: $nickname)
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
    InputNicknameView(isInputNicknameViewPresented: .constant(false))
}
