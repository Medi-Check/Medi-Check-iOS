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
    @State private var isHomeViewPresented: Bool = false
    var body: some View {
        VStack {
            Button {
                isHomeViewPresented = true
            } label: {
                ZStack {
                    Rectangle()
                        .cornerRadius(15, corners: .allCorners)
                        .foregroundStyle(.gray)
                    AsyncImage(url: URL(string: image)) { img in
                        img
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image("Profile")
                    }
                }
            }
            .navigationDestination(isPresented: $isHomeViewPresented) {
                HomeView()
            }
            
            Text(name)
                .font(.system(size: CGFloat.adaptiveSize(portraitIPhone: 20, landscapeIPhone: 20, portraitIPad: 40, landscapeIPad: 40), weight: .bold))
        }
        .cornerRadius(15, corners: .allCorners)
    }
}

#Preview {
    ProfileView(image: "Profile", name: "name")
}
