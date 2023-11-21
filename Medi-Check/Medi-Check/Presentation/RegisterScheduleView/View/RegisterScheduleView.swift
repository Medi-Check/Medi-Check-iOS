//
//  RegisterScheduleView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/15/23.
//

import SwiftUI

struct RegisterScheduleView: View {
    @EnvironmentObject var userData: UserData
    @ObservedObject var viewModel = RegisterScheduleViewModel()
    @State private var medicineName: String = ""
    @State private var selectWeekDay: [String] = []
    @State private var selectTime: [String] = []
    @State private var memberName: String = ""
    @State private var hour: Int = 0
    @State private var minute: Int = 0
    @State private var timeString: String = ""
    @State private var amounts: String = ""
    let weekArray: [String] = [ "SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY", "EVERYDAY" ]
    
    let timeSlots: [String] = (0..<48).map { index in
        let hour = index / 2
        let minute = (index % 2) * 30
        return String(format: "%02d:%02d", hour, minute)
    }
    
    
    var body: some View {
        ZStack {
            SecondBackgroundView()
            VStack {
                Text("약 일정 등록")
                    .font(.title)
                    .bold()
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                
                Spacer()
                
                    HStack(alignment: .center, spacing: CGFloat.adaptiveSize(portraitIPhone: 10, landscapeIPhone: 10, portraitIPad: 20, landscapeIPad: 20)) {
                        ForEach(viewModel.medicines.indices, id: \.self) { index in
                            let medicineInfo = viewModel.medicines[index]
                            Button {
                                medicineName = medicineInfo.medicineName
                                amounts = String(medicineInfo.amounts)
                            } label: {
                                VStack(alignment: .center) {
                                    AsyncImage(url: URL(string: medicineInfo.imagUrl)) { img in
                                        img
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding(5)
                                    } placeholder: {
                                        Image("Pill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding(5)
                                    }
                                    Spacer()
                                    Text(medicineInfo.medicineName)
                                        .font(.title3)
                                        .bold()
                                        .foregroundStyle(Color.black)
                                        .padding(.bottom, 10)
                                    
                                }
                            }
                            .frame(width: CGFloat.adaptiveSize(portraitIPhone: 50, landscapeIPhone: 50, portraitIPad: 150, landscapeIPad: 150), height: CGFloat.adaptiveSize(portraitIPhone: 50, landscapeIPhone: 50, portraitIPad: 150, landscapeIPad: 150))
                            .background(Color.white)
                            .cornerRadius(15, corners: .allCorners)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.black, lineWidth: 4)
                                )
                            .padding(5)
                        }
                    }
                // 기기별로 사이즈 설정할 것
                .frame(height: CGFloat.adaptiveSize(portraitIPhone: 50, landscapeIPhone: 50, portraitIPad: 200, landscapeIPad: 200))
                .padding(.leading, CGFloat.adaptiveSize(portraitIPhone: 10, landscapeIPhone: 10, portraitIPad: 20, landscapeIPad: 20))
                .padding(.trailing, CGFloat.adaptiveSize(portraitIPhone: 10, landscapeIPhone: 10, portraitIPad: 20, landscapeIPad: 20))
                
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 50) {
                    HStack {
                        Text("약 이름 : ")
                        TextField("ex) 타이레놀", text: $medicineName)
                            .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                    }
                    HStack {
                        Text("복용 요일 : ")
                        HStack {
                            ForEach(weekArray.indices, id: \.self) { index in
                                var isSelected: Bool = selectWeekDay.contains(weekArray[index])
                                Button {
                                    if let matchedDayIndex = selectWeekDay.firstIndex(where: { $0 == weekArray[index] }) {
                                        selectWeekDay.remove(at: matchedDayIndex)
                                    } else {
                                        if weekArray[index] == "EVERYDAY" {
                                            selectWeekDay.removeAll()
                                            selectWeekDay.append(weekArray[index])
                                        } else {
                                            selectWeekDay.append(weekArray[index])
                                        }
                                    }
                                    print(selectWeekDay)
                                    
                                    
                                } label: {
                                    var textColor: Color = isSelected ? Color.blue : Color.black
                                    
                                    Text("\(weekArray[index])")
                                        .foregroundStyle(textColor)
                                }
                            }
                        }
                    }
                    HStack {
                        Text("복용 시간 : ")
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(timeSlots.indices, id: \.self) { index in
                                    var isSelected: Bool = selectTime.contains(timeSlots[index])
                                    Button {
                                        if let matchedDayIndex = selectTime.firstIndex(where: { $0 == timeSlots[index] }) {
                                            selectTime.remove(at: matchedDayIndex)
                                        } else {
                                            selectTime.append(timeSlots[index])
                                            
                                        }
                                        print(selectTime)
                                    } label: {
                                        var textColor: Color = isSelected ? Color.blue : Color.black
                                        
                                        Text("\(timeSlots[index])")
                                            .foregroundStyle(textColor)
                                    }
                                }
                            }
                        }
                    }
                    HStack {
                        Text("개수 : ")
                        TextField("ex) 5", text: $amounts)
                            .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                    }
                }
                .padding(.leading, CGFloat.adaptiveSize(portraitIPhone: 10, landscapeIPhone: 10, portraitIPad: 20, landscapeIPad: 20))
                .padding(.trailing, CGFloat.adaptiveSize(portraitIPhone: 10, landscapeIPhone: 10, portraitIPad: 20, landscapeIPad: 20))
                .foregroundStyle(Color.gray)
                
                Spacer()
                
                Button {
                    Task {
                        await viewModel.fetchData(week: selectWeekDay, medicineName: medicineName, memberName: userData.currnetProfile.nickName, time: selectTime, takeAmount: Int(amounts) ?? 0)
                    }
                } label: {
                    Text("일정 등록하기")
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .foregroundStyle(Color.white)
                }
                .background(Color.gray)
                
                Spacer()
            }
        }
        .onAppear {
            Task {
                print("TEST")
                await viewModel.fetchMyMedicineData(memberName: userData.currnetProfile.nickName)
                print(viewModel.$medicines)
                print(userData.currnetProfile)
            }
        }
    }
    
}

#Preview {
    RegisterScheduleView()
        .environmentObject(UserData())
}
