//
//  OnBoardingView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 10/28/23.
//

import SwiftUI

struct OnBoardingView: View {
    @State private var indexOfTitle: Int = 0
    @State private var buttonText: String = "다음"
    @State private var isInputFamilyCodeViewPresented = false
    
    var body: some View {
        GeometryReader { geometry in
            let geoWidth = geometry.size.width
            let geoHeight = geometry.size.height
            
            ZStack {
                FirstBackgroundView()
                VStack {
                    TabView(selection: $indexOfTitle) {
                        Text("TEST 1")
                            .tag(0)
                        Text("TEST 2")
                            .tag(1)
                        Text("TEST 3")
                            .tag(2)
                        
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    
                    if 0 <= indexOfTitle && indexOfTitle < 2 {
                        Button {
                            indexOfTitle += 1
                            isInputFamilyCodeViewPresented = false
                        } label: {
                            BasicButtonLabel(text: "다음", strokeWidth: 1, fontSize: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.1, landscapeIPhone: geoWidth * 0.05, portraitIPad: geoWidth * 0.07, landscapeIPad: geoWidth * 0.05), width: geoWidth, height: geoHeight * 0.07)
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                .background(Color.MediCheckMainColor)
                        }
                    } else if 2 <= indexOfTitle {
                        Button {
                            indexOfTitle = 2
                            isInputFamilyCodeViewPresented = true
                        } label: {
                            BasicButtonLabel(text: "완료", strokeWidth: 1, fontSize: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.1, landscapeIPhone: geoWidth * 0.05, portraitIPad: geoWidth * 0.07, landscapeIPad: geoWidth * 0.05), width: geoWidth, height: geoHeight * 0.07)
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                .background(Color.MediCheckMainColor)
                        }
                        .navigationDestination(isPresented: $isInputFamilyCodeViewPresented) {
                            InputFamilyCodeView()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    OnBoardingView()
}
