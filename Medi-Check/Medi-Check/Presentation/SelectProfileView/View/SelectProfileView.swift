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
    @State private var isAddProfileViewPresented: Bool = false
    
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
                    HStack(spacing: CGFloat.adaptiveSize(portraitIPhone: 10, landscapeIPhone: 10, portraitIPad: 20, landscapeIPad: 20)) {
                        ForEach(dummyProfileImages.indices, id: \.self) { index in
                            ProfileView(image: dummyProfileImages[index], name: dummyName[index])
                                .frame(width: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.3, landscapeIPhone: geoWidth * 0.3, portraitIPad: geoWidth * 0.3, landscapeIPad: geoWidth * 0.3), height: CGFloat.adaptiveSize(portraitIPhone: geoHeight * 0.2, landscapeIPhone: geoHeight * 0.5, portraitIPad: geoHeight * 0.25, landscapeIPad: geoHeight * 0.4))
                            
                        }
                    }
                    
                    VStack {
                        Button {
                            isAddProfileViewPresented = true
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
                            .navigationDestination(isPresented: $isAddProfileViewPresented) {
                                
                            }
                            
                        }
                        Text("프로필 추가")
                            .font(.system(size: CGFloat.adaptiveSize(portraitIPhone: 15, landscapeIPhone: 15, portraitIPad: 40, landscapeIPad: 40), weight: .bold))
                    }
                    
                }
            }
        }
    }
}

#Preview {
    SelectProfileView()
}
