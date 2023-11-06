//
//  SelectProfileView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/6/23.
//

import SwiftUI

struct SelectProfileView: View {
    let dummyProfileImages: [String] = ["star.fill", "star.fill", "star.fill"]
    
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
                    HStack {
                        ForEach(dummyProfileImages, id: \.self) { image in
                                Image(systemName: image)
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
