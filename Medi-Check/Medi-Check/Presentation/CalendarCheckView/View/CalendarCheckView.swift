//
//  CalendarCheckView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/15/23.
//

import SwiftUI

struct CalendarCheckView: View {
    @ObservedObject var viewModel = CalendarCheckViewModel()
    
    var body: some View {
        Button {
            Task {
                await viewModel.fetchData(memberName: "웅구형")
            }
        } label: {
            Text("Button")
                .background(Color.blue)
        }
    }
}

#Preview {
    CalendarCheckView()
}
