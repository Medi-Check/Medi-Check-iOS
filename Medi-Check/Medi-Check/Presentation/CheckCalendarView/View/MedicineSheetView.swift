//
//  MedicineSheetView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/19/23.
//

import SwiftUI

struct MedicineSheetView: View {
    let scheduleInfo: CheckCalendarViewModel.getScheduleDTO
    @Binding var isSheetPresented: Bool
    @ObservedObject var viewModel = MedicineSheetViewModel()
    
    var body: some View {
        VStack {
            
            Text("\(scheduleInfo.medicineName) 약을 복용하셨습니까?\n복용하셨다면 Yes, 하지 않으셨다면 No를 눌러주세요.")
            
            HStack {
                Button {
                    Task {
                        await viewModel.fetchData(takeMedicineId: scheduleInfo.takeMedicineId, checked: 1)
                        isSheetPresented = false
                    }
                } label: {
                    Text("Yes")
                }
                .background(Color.green)
                
                Button {
                    Task {
                        await viewModel.fetchData(takeMedicineId: scheduleInfo.takeMedicineId, checked: 0)
                        isSheetPresented = false
                    }
                } label: {
                    Text("No")
                }
                .background(Color.red)
            }
            
        }
    }
}

#Preview {
    MedicineSheetView(scheduleInfo: CheckCalendarViewModel.getScheduleDTO(medicineName: "타이레놀", takeMedicineId: 1, week: "SUNDAY", hour: 17, minute: 30, amounts: 5, medicineImgUrl: "Profile", status: false), isSheetPresented: .constant(false))
}
