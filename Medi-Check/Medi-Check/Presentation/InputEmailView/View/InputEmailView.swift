//
//  InputEmailView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/2/23.
//

import SwiftUI

struct InputEmailView: View {
    @State var email: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                FirstBackgroundView()
                VStack {
                    Text("이메일을 입력하세요.")
                        .font(.system(size: geometry.size.width * 0.04, weight: .bold))
                        .padding(EdgeInsets(top: geometry.size.height * 0.2, leading: 0, bottom: geometry.size.height * 0.15, trailing: 0))
                    
                    VStack(alignment: .leading) {
                        Text("이메일")
                            .font(.system(size: geometry.size.width * 0.02, weight: .bold))
                            .foregroundStyle(Color.gray)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: geometry.size.height * 0.05, trailing: 0))
                        
                        TextField("EX) jmtkd9196@gmail.com", text: $email)
                            .font(.system(size: geometry.size.width * 0.025, weight: .bold))
                        
                        Rectangle()
                            .frame(height: 1.5)
                    }
                    .frame(width: geometry.size.width * 0.5, alignment: .leading)
                    .foregroundStyle(Color.gray)
                    
                    Spacer()
                    Button {
                        
                    } label: {
                        BasicButtonLabel(text: "완료", strokeWidth: 1, fontSize: geometry.size.height * 0.05, width: geometry.size.width, height: geometry.size.height * 0.07)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                            .background(Color.MediCheckMainColor)
                    }
                }
//                .background(Color.red.opacity(0.2))
            }
        }
    }
}

#Preview {
    InputEmailView(email: "EX) jmtkd9196@gmail.com")
}
