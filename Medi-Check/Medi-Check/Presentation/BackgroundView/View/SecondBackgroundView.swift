//
//  SecondBackgroundView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 10/31/23.
//

import SwiftUI

struct SecondBackgroundView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Color.clear
                    Image("Capsule")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.5)
                        .offset(x: -geometry.size.width * 0.4, y: -geometry.size.height * 0.4)
                    
                    Image("Pill")
                        .resizable()
                        .rotationEffect(Angle(degrees: 0))
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.35, height: geometry.size.height * 0.35)
                        .offset(x: -geometry.size.width * 0.2, y: -geometry.size.height * 0.15)
                    
                    Image("Capsule")
                        .resizable()
                        .rotationEffect(Angle(degrees: 100))
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.5)
                        .offset(x: geometry.size.width * 0.1, y: geometry.size.height * 0.1)
                    
                    Image("Pill")
                        .resizable()
                        .rotationEffect(Angle(degrees: 310))
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.3)
                        .offset(x: geometry.size.width * 0.4, y: geometry.size.height * 0.3)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    SecondBackgroundView()
}
