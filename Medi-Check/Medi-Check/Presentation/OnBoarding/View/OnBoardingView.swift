//
//  OnBoardingView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 10/28/23.
//

import SwiftUI

struct OnBoardingView: View {
    @State private var indexOfTitle: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
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
                    Button {
                        if 0 <= indexOfTitle && indexOfTitle < 2 {
                            indexOfTitle += 1
                        } else if indexOfTitle >= 2 {
                            
                        }
                    } label: {
                        if indexOfTitle <= 0 {
                            BasicButtonLabel(text: "다음", strokeWidth: 1, fontSize: geometry.size.height * 0.05, width: geometry.size.width, height: geometry.size.height * 0.07)
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                .background(Color.MediCheckMainColor)
                        } else if indexOfTitle <= 2 {
                            BasicButtonLabel(text: "완료", strokeWidth: 1, fontSize: geometry.size.height * 0.05, width: geometry.size.width, height: geometry.size.height * 0.07)
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                .background(Color.MediCheckMainColor)
                            
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
