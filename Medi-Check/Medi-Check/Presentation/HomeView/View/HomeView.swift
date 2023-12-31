//
//  HomeView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/6/23.
//

import SwiftUI

struct HomeView: View {
    @State private var indexOfView: Int = 0
    
    
    @EnvironmentObject var userData: UserData
    var body: some View {
        GeometryReader { geometry in
            let geoWidth = geometry.size.width
            let geoHeight = geometry.size.height
            ZStack(alignment: .topTrailing) {
                VStack {
                    TabView(selection: $indexOfView) {
                        
                        DashboardView(urlToLoad: "https://dashboard-trainingapps-eks004.sa.wise-paas.com/d/MUrqFy4Sk/medicheck?orgId=2283&from=1700522004891&to=1700565204891")
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
                                Image(systemName: "calendar")
                            }
                            .tag(2)
                        
                    }
                }
                
                Text("\(userData.currnetProfile.nickName)님 환영합니다.")
                    .font(.title2)
                    .bold()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
            }
        }
    }
}

//#Preview {
//    HomeView()
//        .environmentObject(UserData())
//}
