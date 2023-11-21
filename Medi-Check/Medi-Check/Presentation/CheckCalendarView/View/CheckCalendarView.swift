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
    private var weekDictionaryKorToEng: [String: String] = ["월": "MONDAY", "화": "TUESDAY", "수": "WEDNESDAY", "목": "THURSDAY", "금": "FRIDAY", "토": "SATURDAY", "일": "SUNDAY", "매일": "EVERYDAY"]
    private var weekDictionaryEngToKor: [String: String] = ["MONDAY": "월요일", "TUESDAY": "화요일", "WEDNESDAY": "수요일", "THURSDAY": "목요일", "FRIDAY": "금요일", "SATURDAY": "토요일" , "SUNDAY": "일요일", "EVERYDAY": "매일"]
    @State private var filteringWeekArray: [CheckCalendarViewModel.getScheduleDTO] = []
    @State private var selectSchedule: CheckCalendarViewModel.getScheduleDTO?
    
    let weekdays: [String] = ["월", "화", "수", "목", "금", "토", "일", "매일"]
    
    var body: some View {
        ZStack {
            FirstBackgroundView()
            VStack {
                HStack {
                    ForEach(weekdays.indices, id: \.self) { index in
                        //                    let buttonColor = weekdays[index] == selectWeekDay ? Color.gray : Color.white
                        Button {
                            selectWeekDay = weekdays[index]
                            filteringWeekArray = viewModel.schedules.filter { $0.week == weekDictionaryKorToEng[selectWeekDay] }
                            print("필터링 테스트 : \(filteringWeekArray)")
                        } label: {
                            Text(weekdays[index])
                                .foregroundStyle(weekdays[index] == selectWeekDay ? Color.white : Color.black)
                                .font(.title)
                                .bold()
                                .padding() // 텍스트 주변에 여유 공간 추가
                                .background(Circle() // 원형 배경
                                    .fill(weekdays[index] == selectWeekDay ? Color.gray : Color.white) // 원형 배경 색상 설정
                                )
                                .overlay(
                                    Circle().stroke(Color.black, lineWidth: 2) // 원형 테두리 추가
                                )
                        }
                    }
                }
                ScrollView(.vertical) {
                    ForEach(filteringWeekArray.indices, id: \.self) { index in
                        let schedule = filteringWeekArray[index]
                        let takeMedicineCheckColor = schedule.status ? Color.green : Color.clear
                        HStack {
                            Button {
                                Task {
                                    await viewModel.changeHStackColor(takeMedicineId: schedule.takeMedicineId)
                                    await viewModel.fetchData(memberName: userData.currnetProfile.nickName)
                                    
                                    filteringWeekArray = viewModel.schedules.filter { $0.week == weekDictionaryKorToEng[selectWeekDay] }
                                }
                                selectSchedule = schedule
                                //                            isSheetPresented = true
                            } label: {
                                HStack {
                                    AsyncImage(url: URL(string: schedule.medicineImgUrl)) { img in
                                        img
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 200)
                                            .padding(5)
                                            .background(RoundedRectangle(cornerRadius: 10) // 원형 배경
                                                .fill(Color.white) // 원형 배경 색상 설정
                                            )
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.black, lineWidth: 1)
                                            )
                                            .padding(20)
                                    } placeholder: {
                                        Image("Capsule")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding(5)
                                    }
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("약 이름 : \(schedule.medicineName)")
                                        Text("복용 요일 : \(weekDictionaryEngToKor[schedule.week] ?? "?")")
                                        Text("복용 시간 : \(schedule.hour)시 \(schedule.minute)분")
                                        Text("1회 복용 개수 : \(schedule.amounts)개")
                                    }
                                    .font(.title3)
                                    .bold()
                                    .frame(maxWidth: .infinity)
                                }
                            }
                            .foregroundStyle(Color.black)
                            .padding() // 텍스트 주변에 여유 공간 추가
                            
                            Spacer()
                        }
                        .frame(height: 200)
                        .background(takeMedicineCheckColor)
                        
                        Rectangle()
                            .frame(height: 2) // 굵기 설정
                            .foregroundColor(.gray) // 색상 설정
                            .padding(.vertical) // 위아래 패딩 추가
                        
                        
                    }
                    .sheet(item: $selectSchedule) { schedule in
                        MedicineSheetView(schedule: schedule, selectSchedule: $selectSchedule)
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchData(memberName: /*userData.currnetProfile.nickName*/"이경수")
                    filteringWeekArray = viewModel.schedules.filter { $0.week == weekDictionaryKorToEng["월"] }
                    print("viewModel.schedules: \(viewModel.schedules)")
                    print("fliteringWeekArray: \(filteringWeekArray)")
                }
            }
        }
        
    }
}

//#Preview {
//    CheckCalendarView()
//        .environmentObject(UserData())
//}
