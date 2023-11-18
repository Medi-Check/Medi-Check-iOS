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
    @State private var week: String = ""
    @State private var memberName: String = ""
    @State private var hour: Int = 0
    @State private var minute: Int = 0
    @State private var timeString: String = ""
    @State private var amounts: String = ""
    
    
    var body: some View {
        VStack {
            Text("약 일정 등록")
                .font(.title)
                .bold()
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.medicines.indices, id: \.self) { index in
                        let medicineInfo = viewModel.medicines[index]
                        Button {
                            medicineName = medicineInfo.medicineName
                            amounts = String(medicineInfo.amounts)
                        } label: {
                            Text(medicineInfo.medicineName)
                                .bold()
                                .foregroundStyle(Color.white)
                        }
                        .frame(width: 100)
                        .background(Color.gray)
                    }
                }
            }
            // 기기별로 사이즈 설정할 것
            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            
            
            Spacer()
            
            VStack(spacing: 50) {
                HStack {
                    Text("약 이름 : ")
                    TextField("ex) 타이레놀", text: $medicineName)
                        .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                }
                HStack {
                    Text("복용 요일 : ")
                    TextField("ex) SUNDAY", text: $week)
                        .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                }
                HStack {
                    Text("복용 시간 : ")
                    TextField("ex) 17:30", text: $timeString)
                        .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                }
                HStack {
                    Text("개수 : ")
                    TextField("ex) 5", text: $amounts)
                        .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                }
            }
            .padding()
            .foregroundStyle(Color.gray)
            
            Spacer()
            
            Button {
                Task {
                    await viewModel.fetchData(week: week, medicineName: medicineName, memberName: userData.currnetProfile.nickName, hour: Int(hour) , minute: Int(minute) , amounts: Int(amounts) ?? 0)
                }
            } label: {
                Text("RegisterScheduleView")
            }
            
            Spacer()
        }
        .onAppear {
            Task {
                print("TEST")
                await viewModel.fetchMyMedicinesData(memberName: userData.currnetProfile.nickName)
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
