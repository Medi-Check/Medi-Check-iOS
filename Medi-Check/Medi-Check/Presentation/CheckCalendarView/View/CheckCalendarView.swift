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
                ForEach(viewModel.schedules.indices, id: \.self) { index in
                    let schedule = viewModel.schedules[index]
                    HStack {
                        Button {
                            
                        } label: {
                            HStack {
                                AsyncImage(url: URL(string: schedule.medicineImgUrl)) { img in
                                    img
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Image("Capsule")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                                VStack(alignment: .leading) {
                                    Text("약 이름 : \(schedule.medicineName)")
                                        .frame(maxWidth: .infinity)
                                    Text("복용 요일 : \(schedule.week)")
                                    Text("복용 시간 : \(schedule.hour)시 \(schedule.minute)분")
                                }
                            }
                        }
                        .foregroundStyle(Color.black)
                        .sheet(isPresented: $isSheetPresented) {
                            
                        }
                        
                        Spacer()
                    }
                    .frame(height: 100)
                    .background(Color.gray)
                    
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
