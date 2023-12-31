//
//  InputEmailView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/2/23.
//

import SwiftUI

struct InputFamilyCodeView: View {
    @State private var familyCode: String = "vt1u7X"
    @State private var goToInputEmailView: Bool = false
    @State private var goToFaceIdView: Bool = false
    
    @ObservedObject var viewModel = InputFamilyCodeViewModel()
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        GeometryReader { geometry in
            let geoWidth = geometry.size.width
            let geoHeight = geometry.size.height
            ZStack {
                FirstBackgroundView()
                VStack {
                    Text("가족코드를 입력하세요.")
                        .font(.system(size: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.08, landscapeIPhone: geoWidth * 0.04, portraitIPad: geoWidth * 0.05, landscapeIPad: geoWidth * 0.05), weight: .bold))
                        .padding(EdgeInsets(top: geoHeight * 0.2, leading: 0, bottom: geoHeight * 0.15, trailing: 0))
                    
                    VStack(alignment: .leading) {
                        Text("이메일")
                            .font(.system(size: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.05, landscapeIPhone: geoWidth * 0.03, portraitIPad: geoWidth * 0.02, landscapeIPad: geoWidth * 0.02), weight: .bold))
                            .foregroundStyle(Color.gray)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: geoHeight * 0.05, trailing: 0))
                        
                        TextField("가족코드 6자리를 입력하세요.", text: $familyCode)
                            .font(.system(size: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.06, landscapeIPhone: geoWidth * 0.04, portraitIPad: geoWidth * 0.025, landscapeIPad: geoWidth * 0.025), weight: .bold))
                        
                        Rectangle()
                            .frame(height: 1.5)
                        
                        
                        Button {
                            goToInputEmailView = true
                        } label: {
                            Text("코드 발급 & 재전송")
                        }
                        .font(.system(size: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.04, landscapeIPhone: geoWidth * 0.025, portraitIPad: geoWidth * 0.015, landscapeIPad: geoWidth * 0.015), weight: .bold))
                        .navigationDestination(isPresented: $goToInputEmailView) {
                            InputEmailView()
                        }
                    
                        
                    }
                    .frame(width: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.85, landscapeIPhone: geoWidth * 0.63, portraitIPad: geoWidth * 0.5, landscapeIPad: geoWidth * 0.5), alignment: .leading)
                    .foregroundStyle(Color.gray)
                    
                    Spacer()
                    Button {
                        Task {
                            if familyCode.count == 6 {
                                await viewModel.fetchData(familyCode: familyCode)
                                userData.members = UserData.getMembersDtoToMembers(members: viewModel.members)
                                userData.familyCode = familyCode
                                print(userData.members)
                            }
                        }
                        goToFaceIdView = true
                    } label: {
                        BasicButtonLabel(text: "완료", strokeWidth: 1, fontSize: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.1, landscapeIPhone: geoWidth * 0.05, portraitIPad: geoWidth * 0.07, landscapeIPad: geoWidth * 0.05), width: geoWidth, height: geoHeight * 0.07)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                            .background(Color.MediCheckMainColor)
                    }
                    .navigationDestination(isPresented: $goToFaceIdView) {
                        FaceIdView(goToFaceIdView: $goToFaceIdView)
                    }
                }
            }
        }
        .onAppear {
            if userData.familyCode != "" {
                goToFaceIdView = true
            } else {
                goToFaceIdView = false
            }
        }
        .onTapGesture {
            self.endTextEditing()
        }
    }
}

//#Preview {
//    InputFamilyCodeView(familyCode: "가족코드 6자리를 입력하세요.")
//}
