//
//  MedicineSheetView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/19/23.
//

import SwiftUI

struct MedicineSheetView: View {
    var schedule: CheckCalendarViewModel.getScheduleDTO
    @Binding var selectSchedule: CheckCalendarViewModel.getScheduleDTO?
    @ObservedObject var viewModel = MedicineSheetViewModel()
    @State private var rating = 0
    
    var body: some View {
        VStack {
            Text("\(schedule.medicineName) 약을 복용하셨습니까?\n복용하셨다면 Yes, 하지 않으셨다면 No를 눌러주세요.")
                .font(.title)
            
            VStack {
                Text("별점을 입력해주세요.")
                    .font(.title2)
                HStack {
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= rating ? "star.fill" : "star")
                            .foregroundColor(index <= rating ? .yellow : .gray)
                            .onTapGesture {
                                rating = index
                            }
                    }
                }
            }
            .padding(20)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
            
            
            HStack {
                Button {
                    Task {
                        await viewModel.fetchCheckTakeMedicineById(takeMedicineId: schedule.takeMedicineId, checked: 1)
                        selectSchedule = nil
                    }
                } label: {
                    Text("Yes")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color.white)
                        .frame(width: 50, height: 30)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10) // 원형 배경
                            .fill(Color.green) // 원형 배경 색상 설정
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
                
                Button {
                    Task {
                        await viewModel.fetchCheckTakeMedicineById(takeMedicineId: schedule.takeMedicineId, checked: 0)
                        await viewModel.fetchHealthRate(healthRate: rating, eatMedicineId: schedule.takeMedicineId)
                        selectSchedule = nil
                    }
                } label: {
                    Text("No")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color.white)
                        .frame(width: 50, height: 30)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10) // 원형 배경
                            .fill(Color.red) // 원형 배경 색상 설정
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
            }
            
        }
    }
}

//#Preview {
//    MedicineSheetView(scheduleInfo: CheckCalendarViewModel.getScheduleDTO(id: 1, medicineName: "타이레놀", takeMedicineId: 1, week: "SUNDAY", hour: 17, minute: 30, amounts: 5, medicineImgUrl: "Profile", status: false), isSheetPresented: .constant(false))
//}
