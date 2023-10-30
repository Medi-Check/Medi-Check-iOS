//
//  OnBoardingView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 10/28/23.
//

import SwiftUI

struct OnBoardingView: View {
    @State private var indexOfTitle: Int = 1
    
    var body: some View {
        ZStack {
            OnBoardingBackgroundView()
            TabView(selection: $indexOfTitle) {
                
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

#Preview {
    OnBoardingView()
}
