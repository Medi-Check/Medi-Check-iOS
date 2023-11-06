//
//  ProfileView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/6/23.
//

import SwiftUI

struct ProfileView: View {
    let image: String
    let name: String
    var body: some View {
        VStack {
            Button {
                
            } label: {
                ZStack {
                    Rectangle()
                        .cornerRadius(15, corners: .allCorners)
                        .foregroundStyle(.gray)
                    Image(image)
                        .resizable()
                        .scaledToFit()
                }
            }
            
            Text(name)
                .font(.system(size: CGFloat.adaptiveSize(portraitIPhone: 15, landscapeIPhone: 15, portraitIPad: 30, landscapeIPad: 30), weight: .bold))
        }
        .cornerRadius(15, corners: .allCorners)
    }
}

#Preview {
    ProfileView(image: "Profile", name: "name")
}
