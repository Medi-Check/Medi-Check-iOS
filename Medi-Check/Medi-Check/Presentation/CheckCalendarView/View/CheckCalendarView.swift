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
    @State private var selectWeekDay: String = "월"
    @State private var weekDictionary: [String: String] = ["월": "MONDAY", "화": "TUESDAY", "수": "WEDNESDAY", "목": "THURSDAY", "금": "FRIDAY", "토": "SATURDAY", "일": "SUNDAY", "매일": "EVERYDAY"]
    @State private var filteringWeekArray: [CheckCalendarViewModel.getScheduleDTO] = []
    
    let weekdays: [String] = ["월", "화", "수", "목", "금", "토", "일", "매일"]
    
    var body: some View {
        VStack {
            HStack {
                ForEach(weekdays.indices, id: \.self) { index in
                    let buttonColor = weekdays[index] == selectWeekDay ? Color.gray : Color.white
                    Button {
                        selectWeekDay = weekdays[index]
                        filteringWeekArray = viewModel.schedules.filter { $0.week == weekDictionary[selectWeekDay] }
                        print("필터링 테스트 : \(filteringWeekArray)")
                    } label: {
                        Text(weekdays[index])
                            .background(buttonColor)
                    }
                }
            }
            ScrollView(.vertical) {
                ForEach(filteringWeekArray.indices, id: \.self) { index in
                    let schedule = filteringWeekArray[index]
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
                filteringWeekArray = viewModel.schedules.filter { $0.week == weekDictionary["월"] }
            }
        }
    }
}

#Preview {
    CheckCalendarView()
        .environmentObject(UserData())
}
