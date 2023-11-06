//
//  HomeView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/6/23.
//

import SwiftUI

struct HomeView: View {
    @State private var indexOfView: Int = 0
    var body: some View {
        GeometryReader { geometry in
            let geoWidth = geometry.size.width
            let geoHeight = geometry.size.height
            VStack {
                TabView(selection: $indexOfView) {
                    
                    ZStack {
                        FirstBackgroundView()
                        Text("TEST1")
                    }
                    .tabItem {
                        Image(systemName: "chart.bar.xaxis")
                    }
                    .tag(0)
                    
                    Text("TEST2")
                        .tabItem {
                            Image(systemName: "pill.fill")
                        }
                        .tag(1)
                    
                    Text("TEST3")
                        .tabItem {
                            Image(systemName: "star.fill")
                        }
                        .tag(2)
                    
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
