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
                VStack(spacing: 0) {
                    Image("MediCheck")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth * 0.3, height: screenWidth * 0.3)
                    StrokeText(text: "Medi-Check", width: 1, color: Color.black)
                        .foregroundColor(.white)
                        .font(.system(size: screenWidth * 0.05, weight: .bold))
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
