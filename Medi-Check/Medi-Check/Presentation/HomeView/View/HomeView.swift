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
                    
                    DashboardView(urlToLoad: "https://dashboard-trainingapps-eks004.sa.wise-paas.com/d/Tns3Y0ZMz/core2_1215_sk?orgId=1&refresh=3s")
                        .ignoresSafeArea()
                        .tabItem {
                            Image(systemName: "chart.bar.xaxis")
                        }
                        .tag(0)
                    
                    RegistrationDrugView()
                        .tabItem {
                            Image(systemName: "pill.fill")
                        }
                        .tag(1)
                    
                    ScheduleView()
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
