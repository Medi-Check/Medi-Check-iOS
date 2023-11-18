//
//  RegisterScheduleView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/15/23.
//

import SwiftUI

struct RegisterScheduleView: View {
    @ObservedObject var viewModel = RegisterScheduleViewModel()
    
    var body: some View {
        Button {
            Task {
                await viewModel.fetchData(week: "SUNDAY", medicineName: "광동 평위천", memberName: "웅구", hour: 11, minute: 23, amounts: 3)
            }
        } label: {
            Text("RegisterScheduleView")
        }
    }
}

#Preview {
    RegisterScheduleView()
}
