//
//  CustomBackButton.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/20/23.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
            Button {
                dismiss()
            } label: {
                Text("X")
            }
    }
}

#Preview {
    CustomBackButton()
}
