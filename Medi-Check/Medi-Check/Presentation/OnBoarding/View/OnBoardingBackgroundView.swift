//
//  FirstOnBoardingView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 10/28/23.
//

import SwiftUI

struct OnBoardingBackgroundView: View {
    
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
                        .rotationEffect(Angle(degrees: 310))
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.3)
                        .offset(x: geometry.size.width * 0.4, y: geometry.size.height * 0.4)
                }
                
                StrokeText(text: "다음", width: 1, color: Color.black)
                    .foregroundColor(.white)
                    .font(.system(size: geometry.size.height * 0.05, weight: .bold))
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.07, alignment: .top)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .background(Color.MediCheckMainColor)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        
    }
}

#Preview {
    OnBoardingBackgroundView()
}
