//
//  SplashView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 2023/10/10.
//

import SwiftUI

struct SplashView: View {
    let screenHeight = UIScreen.main.bounds.size.height
    let screenWidth = UIScreen.main.bounds.size.width
    var body: some View {
        NavigationStack {
            ZStack {
                Color.MediCheckMainColor.edgesIgnoringSafeArea(.all)
                VStack {
                    Image("MediCheck")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth * 0.5, height: screenHeight * 0.5)
                    Text("Medi-Check")
                        .font(.title)
                        .foregroundStyle(Color.white)
                        .bold()
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
