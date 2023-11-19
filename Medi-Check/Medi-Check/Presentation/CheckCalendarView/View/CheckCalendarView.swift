//
//  CheckCalendarView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/15/23.
//

import SwiftUI

struct CheckCalendarView: View {
    @ObservedObject var viewModel = CheckCalendarViewModel()
    @EnvironmentObject var userData: UserData
    @State private var isSheetPresented: Bool = false
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                VStack {
                    ForEach(viewModel.schedules.indices, id: \.self) { index in
                        let schedule = viewModel.schedules[index]
                        HStack {
                            Button {
                                
                            } label: {
                                Text(schedule.medicineName)
                            }
                            .background(Color.gray)
                            .sheet(isPresented: $isSheetPresented) {
                                
                            }
                            
                            Spacer()
                        }
                        .frame(height: 100)
                        .background(Color.black)
                        
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchData(memberName: userData.currnetProfile.nickName)
            }
        }
    }
}

#Preview {
    CheckCalendarView()
        .environmentObject(UserData())
}
