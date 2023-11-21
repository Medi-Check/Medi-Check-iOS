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
    @State private var selectedTime: [String] = []
    @State private var medicineId: Int = 0
    @State private var memberName: String = ""
    @State private var hour: String = ""
    @State private var minute: String = ""
    @State private var timeString: String = ""
    @State private var amounts: String = ""
    let weekArray: [String] = [ "SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY", "EVERYDAY" ]
    private var weekDictionary: [String: String] = ["MONDAY": "월", "TUESDAY": "화", "WEDNESDAY": "수", "THURSDAY": "목", "FRIDAY": "금", "SATURDAY": "토" , "SUNDAY": "일", "EVERYDAY": "매일"]
    let containerNumber: [String] = ["1", "2", "3", "4"]
    let containerDictionary: [String: String] = ["first": "1", "second": "2", "third": "3", "fourth": "4"]
//    let containerStatus: [Bool] = [false, false, false, false]
    @State private var selectedContainer: String = ""
    
    let timeSlots: [String] = (0..<48).map { index in
        let hour = index / 2
        let minute = (index % 2) * 30
        return String(format: "%02d:%02d", hour, minute)
    }
    
    @State private var timeChosen = Date()
    
    let formatter = DateFormatter()
    
    var body: some View {
        ZStack {
            FirstBackgroundView()
            ScrollView {
                Text("약 일정 등록")
                    .font(.system(size: 50))
                    .bold()
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                
                Spacer()
                
                HStack(alignment: .center, spacing: CGFloat.adaptiveSize(portraitIPhone: 10, landscapeIPhone: 10, portraitIPad: 20, landscapeIPad: 20)) {
                    ForEach(viewModel.medicines.indices, id: \.self) { index in
                        let medicineInfo = viewModel.medicines[index]
                        ZStack(alignment: .topTrailing) {
                            Button {
                                medicineName = medicineInfo.medicineName
                                medicineId = medicineInfo.medicineId
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
                            
                            
                            Button {
                                Task {
                                    await viewModel.fetchDeleteMedicine(medicineId: medicineInfo.medicineId)
                                    viewModel.medicines.remove(at: index)
                                }
                            } label: {
                                Text("X")
                                    .foregroundStyle(Color.red)
                                    .padding(5)
                            }
                            .background (
                                Circle()
                                    .stroke(Color.black, lineWidth: 2)
                                    .background(Color.white)
                                    .cornerRadius(50, corners: .allCorners)
                            )
                            .padding(.top, CGFloat.adaptiveSize(portraitIPhone: 5, landscapeIPhone: 5, portraitIPad: 10, landscapeIPad: 10))
                            .padding(.trailing, CGFloat.adaptiveSize(portraitIPhone: 5, landscapeIPhone: 5, portraitIPad: 10, landscapeIPad: 10))
                        }
                        
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
                            .font(.title)
                            .bold()
                        TextField("ex) 타이레놀", text: $medicineName)
                            .font(.title)
                            .bold()
                            .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                    }
                    HStack {
                        Text("복용 요일 : ")
                            .font(.title)
                            .bold()
                        
                        
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
                                            if selectWeekDay.contains("EVERYDAY") {
                                                if let everydayIndex = selectWeekDay.firstIndex(where:  { $0 == "EVERYDAY" }) {
                                                    selectWeekDay.remove(at: everydayIndex)
                                                }
                                            }
                                            selectWeekDay.append(weekArray[index])
                                        }
                                    }
                                    print(selectWeekDay)
                                    
                                    
                                } label: {
                                    //                                    let textColor: Color = isSelected ? Color.blue : Color.black
                                    
                                    Text("\(weekDictionary[weekArray[index]]!)")
                                        .foregroundStyle(isSelected ? Color.white : Color.black)
                                        .font(.title3)
                                        .bold()
                                        .padding()
                                        .background(isSelected ? Color.gray : Color.clear)
                                        .cornerRadius(20, corners: .allCorners)
                                }
                            }
                        }
                    }
                    HStack {
                        Text("복용 시간 : ")
                            .font(.title)
                            .bold()
                        
                        DatePicker("", selection: $timeChosen, displayedComponents: .hourAndMinute)
                            .datePickerStyle(CompactDatePickerStyle())
                            .labelsHidden()
                            .clipped()
                        
                        //                        TextField("시간", text: $hour)
                        //                            .font(.title)
                        //                            .bold()
                        //                            .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                        //                        TextField("분", text: $minute)
                        //                            .font(.title)
                        //                            .bold()
                        //                            .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                        
                        Button {
                            formatter.dateFormat = "HH:mm"
                            print(formatter.string(from: timeChosen))
                            selectedTime.append(formatter.string(from: timeChosen))
                            
                        } label: {
                            Text("시간 추가")
                                .font(.title)
                                .bold()
                                .foregroundStyle(Color.white)
                                .padding()
                                .background(Color.gray)
                                .cornerRadius(20, corners: .allCorners)
                        }
                        //                        ScrollView(.horizontal) {
                        //                            HStack {
                        //                                ForEach(timeSlots.indices, id: \.self) { index in
                        //                                    var isSelected: Bool = selectTime.contains(timeSlots[index])
                        //                                    Button {
                        //                                        if let matchedDayIndex = selectTime.firstIndex(where: { $0 == timeSlots[index] }) {
                        //                                            selectTime.remove(at: matchedDayIndex)
                        //                                        } else {
                        //                                            selectTime.append(timeSlots[index])
                        //
                        //                                        }
                        //                                        print(selectTime)
                        //                                    } label: {
                        //                                        var textColor: Color = isSelected ? Color.blue : Color.black
                        //
                        //                                        Text("\(timeSlots[index])")
                        //                                            .foregroundStyle(textColor)
                        //                                    }
                        //                                }
                        //                            }
                        //                        }
                    }
                    HStack {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(selectedTime.indices, id: \.self) { index in
                                    Button {
                                        selectedTime.remove(at: index)
                                    } label: {
                                        Text(selectedTime[index])
                                            .foregroundStyle(Color.white)
                                            .padding()
                                            .background(Color.gray)
                                            .cornerRadius(20, corners: .allCorners)
                                    }
                                }
                                
                            }
                        }
                    }
                    HStack {
                        Text("개수 : ")
                            .font(.title)
                            .bold()
                        TextField("ex) 5", text: $amounts)
                            .font(.title)
                            .bold()
                            .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            Text("약통 등록 현황")
                                .font(.title)
                                .bold()
                            HStack(spacing: 20) {
                                ForEach(containerNumber.indices, id: \.self) { index in
                                    Button {
                                        if selectedContainer == "" || selectedContainer != containerNumber[index] {
                                            selectedContainer = containerNumber[index]
                                        } else {
                                            selectedContainer = ""
                                        }
                                    } label: {
                                        if viewModel.containerStatus[index] {
                                            Text(containerNumber[index])
                                                .frame(width: 50, height: 50)
                                                .padding(10)
                                                .foregroundStyle(Color.black)
                                                .background(RoundedRectangle(cornerRadius: 10) // 원형 배경
                                                    .fill(Color.gray) // 원형 배경 색상 설정
                                                )
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.black, lineWidth: 2)
                                                )
                                        } else {
                                                Text(containerNumber[index])
                                                .frame(width: 50, height: 50)
                                                    .padding(10)
                                                    .foregroundStyle(selectedContainer == containerNumber[index] ? Color.white : Color.black)
                                                    .background(RoundedRectangle(cornerRadius: 10) // 원형 배경
                                                        .fill(selectedContainer == containerNumber[index] ? Color.green : Color.white) // 원형 배경 색상 설정
                                                    )
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(Color.black, lineWidth: 2)
                                                    )
                                        }
                                    }
                                    .disabled(viewModel.containerStatus[index])
                                    
                                }
                            }
                        }
                        Spacer()
                    }
                }
                .padding(.leading, CGFloat.adaptiveSize(portraitIPhone: 10, landscapeIPhone: 10, portraitIPad: 20, landscapeIPad: 20))
                .padding(.trailing, CGFloat.adaptiveSize(portraitIPhone: 10, landscapeIPhone: 10, portraitIPad: 20, landscapeIPad: 20))
                .foregroundStyle(Color.gray)
                
                Spacer()
                
                Button {
                    Task {
                        await viewModel.fetchData(week: selectWeekDay, medicineName: medicineName, memberName: userData.currnetProfile.nickName, time: selectedTime, takeAmount: Int(amounts) ?? 0)
                        await viewModel.fetchRegisterContainer(medicineId: medicineId, containerId: Int(selectedContainer) ?? 0)
                    }
                } label: {
                    Text("일정 등록하기")
                        .font(.title)
                        .bold()
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .foregroundStyle(Color.white)
                }
                .background(Color.gray)
                .cornerRadius(20, corners: .allCorners)
                .padding(.top, 30)
                
                Spacer()
            }
        }
        .onAppear {
            Task {
                print("TEST")
                await viewModel.fetchMyMedicineData(memberName: userData.currnetProfile.nickName)
                await viewModel.fetchContainerStatus()
                print(viewModel.container)
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
