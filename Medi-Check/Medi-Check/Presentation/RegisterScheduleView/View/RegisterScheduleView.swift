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
                await viewModel.fetchData(week: "MONDAY", medicineName: "경수약", memberName: "경수", hour: 19, minute: 35, amounts: 3)
            }
        } label: {
            Text("RegisterScheduleView")
        }
    }
}

#Preview {
    RegisterScheduleView()
}
