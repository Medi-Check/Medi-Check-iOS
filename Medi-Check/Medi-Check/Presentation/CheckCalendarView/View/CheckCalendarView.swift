//
//  CheckCalendarView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/15/23.
//

import SwiftUI

struct CheckCalendarView: View {
    @ObservedObject var viewModel = CheckCalendarViewModel()
    
    var body: some View {
        Button {
            Task {
                await viewModel.fetchData(memberName: "웅구")
            }
        } label: {
            Text("Button")
                .background(Color.blue)
        }
    }
}

#Preview {
    CheckCalendarView()
}
