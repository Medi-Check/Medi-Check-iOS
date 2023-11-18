//
//  RegisterScheduleView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/15/23.
//

import SwiftUI

struct RegisterScheduleView: View {
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
                    await viewModel.fetchData(week: week, medicineName: medicineName, memberName: "웅구", hour: Int(hour) ?? 0, minute: Int(minute) ?? 0, amounts: Int(amounts) ?? 0)
                }
            } label: {
                Text("RegisterScheduleView")
            }
            
            Spacer()
        }
    }
    
}

#Preview {
    RegisterScheduleView()
}
