//
//  SelectProfileView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/6/23.
//

import SwiftUI

struct SelectProfileView: View {
    //    let dubbyProfiles: [Profile] = []
    let dummyProfileImages: [String] = ["Profile", "Profile", "Profile"]
    let dummyName: [String] = ["Name", "Name", "Name"]
    @EnvironmentObject var userData: UserData
    //    @ObservedObject var viewModel = SelectProfileViewModel()
    @State private var goToInputNicknameView: Bool = false
    @Binding var goToSelectProfileView: Bool
    
    
    var body: some View {
        GeometryReader { geometry in
            let geoWidth = geometry.size.width
            let geoHeight = geometry.size.height
            ZStack {
                SecondBackgroundView()
                VStack(spacing: 10) {
                    Text("프로필을 선택하세요.")
                        .font(.system(size: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.08, landscapeIPhone: geoWidth * 0.04, portraitIPad: geoWidth * 0.07, landscapeIPad: geoWidth * 0.05), weight: .bold))
                        .padding(EdgeInsets(top: geoHeight * 0.1, leading: 0, bottom: 0, trailing: 0))
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: CGFloat.adaptiveSize(portraitIPhone: 10, landscapeIPhone: 10, portraitIPad: 20, landscapeIPad: 20)) {
                            ForEach(userData.members.indices, id: \.self) { index in
                                let userInfo = userData.members[index]
                                ProfileView(image: userInfo.profileImage, name: userInfo.nickName)
                                    .frame(width: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.3, landscapeIPhone: geoWidth * 0.3, portraitIPad: geoWidth * 0.3, landscapeIPad: geoWidth * 0.3), height: CGFloat.adaptiveSize(portraitIPhone: geoHeight * 0.2, landscapeIPhone: geoHeight * 0.5, portraitIPad: geoHeight * 0.25, landscapeIPad: geoHeight * 0.4))
                            }
                        }
                        .frame(height: CGFloat.adaptiveSize(portraitIPhone: geoHeight * 0.3, landscapeIPhone: geoHeight * 0.6, portraitIPad: geoHeight * 0.35, landscapeIPad: geoHeight * 0.5))
                    }
                    
                    VStack {
                        Button {
                            goToInputNicknameView = true
                        } label: {
                            ZStack {
                                Circle()
                                    .stroke(lineWidth: 1)
                                    .frame(width: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.1, landscapeIPhone: geoWidth * 0.08, portraitIPad: geoWidth * 0.1, landscapeIPad: geoWidth * 0.1))
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.05, landscapeIPhone: geoWidth * 0.05, portraitIPad: geoWidth * 0.05, landscapeIPad: geoWidth * 0.05))
                            }
                            .foregroundStyle(Color.black)
                            
                        }
                        .navigationDestination(isPresented: $goToInputNicknameView) {
                            InputNicknameView(goToSelectProfileView: $goToSelectProfileView, goToInputNicknameView: $goToInputNicknameView)
                        }
                        Text("프로필 추가")
                            .font(.system(size: CGFloat.adaptiveSize(portraitIPhone: 15, landscapeIPhone: 15, portraitIPad: 40, landscapeIPad: 40), weight: .bold))
                    }
                }
            }
        }
//        .onAppear {
//            Task {
//                await inputFamilyCodeViewModel.fetchData(familyCode: userData.familyCode)
//                userData.members = UserData.getMembersDtoToMembers(members: inputFamilyCodeViewModel.members)
//            }
//        }
    }
}

//#Preview {
//    SelectProfileView()
//        .environmentObject(UserData())
//}
