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
    
    var body: some View {
        VStack {
            Text("\(schedule.takeMedicineId)")
            Text("\(schedule.medicineName) 약을 복용하셨습니까?\n복용하셨다면 Yes, 하지 않으셨다면 No를 눌러주세요.")
            
            HStack {
                Button {
                    Task {
                        await viewModel.fetchCheckTakeMedicineById(takeMedicineId: schedule.takeMedicineId, checked: 1)
                        selectSchedule = nil
                    }
                } label: {
                    Text("Yes")
                }
                .background(Color.green)
                
                Button {
                    Task {
                        await viewModel.fetchCheckTakeMedicineById(takeMedicineId: schedule.takeMedicineId, checked: 0)
                        selectSchedule = nil
                    }
                } label: {
                    Text("No")
                }
                .background(Color.red)
            }
            Button {
                Task {
                    await viewModel.fetchHealthRate(healthRate:5, eatMedicineId: schedule.takeMedicineId)
                }
            } label: {
                Text("별점 테러")
            }
            
        }
    }
}

//#Preview {
//    MedicineSheetView(scheduleInfo: CheckCalendarViewModel.getScheduleDTO(id: 1, medicineName: "타이레놀", takeMedicineId: 1, week: "SUNDAY", hour: 17, minute: 30, amounts: 5, medicineImgUrl: "Profile", status: false), isSheetPresented: .constant(false))
//}
