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
                            StrokeText(text: "다음", width: 1, color: Color.black)
                                .foregroundColor(.white)
                                .font(.system(size: geometry.size.height * 0.05, weight: .bold))
                                .frame(width: geometry.size.width, height: geometry.size.height * 0.07, alignment: .top)
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                .background(Color.MediCheckMainColor)
                        } else if indexOfTitle <= 2 {
                            StrokeText(text: "완료", width: 1, color: Color.black)
                                .foregroundColor(.white)
                                .font(.system(size: geometry.size.height * 0.05, weight: .bold))
                                .frame(width: geometry.size.width, height: geometry.size.height * 0.07, alignment: .top)
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
