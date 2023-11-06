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
    
    var body: some View {
        GeometryReader { geometry in
            let geoWidth = geometry.size.width
            let geoHeight = geometry.size.height
            ZStack {
                SecondBackgroundView()
                VStack {
                    Text("프로필을 선택하세요.")
                        .font(.system(size: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.08, landscapeIPhone: geoWidth * 0.04, portraitIPad: geoWidth * 0.07, landscapeIPad: geoWidth * 0.05), weight: .bold))
                        .padding(EdgeInsets(top: geoHeight * 0.1, leading: 0, bottom: 0, trailing: 0))
                    HStack(spacing: 10) {
                        ForEach(dummyProfileImages, id: \.self) { image in
                            ProfileView(image: image, name: "Name")
                                .frame(width: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.3, landscapeIPhone: geoWidth * 0.3, portraitIPad: geoWidth * 0.3, landscapeIPad: geoWidth * 0.3), height: CGFloat.adaptiveSize(portraitIPhone: geoHeight * 0.2, landscapeIPhone: geoHeight * 0.5, portraitIPad: geoHeight * 0.25, landscapeIPad: geoHeight * 0.4))
                            
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SelectProfileView()
}
