//
//  InputFamilyCodeView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/2/23.
//

import SwiftUI

struct InputFamilyCodeView: View {
    @State var familyCode: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                FirstBackgroundView()
                VStack {
                    Text("가족 코드를 입력하세요.")
                        .font(.system(size: geometry.size.width * 0.04, weight: .bold))
                        .padding(EdgeInsets(top: geometry.size.height * 0.2, leading: 0, bottom: geometry.size.height * 0.15, trailing: 0))
                    
                    VStack(alignment: .leading) {
                        Text("가족코드")
                            .font(.system(size: geometry.size.width * 0.02, weight: .bold))
                            .foregroundStyle(Color.gray)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: geometry.size.height * 0.05, trailing: 0))
                        
                        TextField("가족코드 6자리를 입력하세요.", text: $familyCode)
                            .font(.system(size: geometry.size.width * 0.025, weight: .bold))
                        
                        Rectangle()
                            .frame(height: 1.5)
                            
                        
                        HStack {
                            Button {
                                
                            } label: {
                                Text("코드 발급")
                            }
                            
                            Text(" / ")
                            
                            Button {
                                
                            } label: {
                                Text("코드 재전송")
                            }
                        }
                        .font(.system(size: geometry.size.width * 0.015, weight: .bold))
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
    InputFamilyCodeView(familyCode: "가족코드 6자리를 입력하세요.")
}
