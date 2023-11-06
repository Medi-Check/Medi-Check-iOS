//
//  FunctionButtonLabel.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/7/23.
//

import SwiftUI

struct FunctionButtonLabel: View {
    let imageSystemName: String
    let innerPadding: CGFloat
    
    var body: some View {
        VStack {
            Button {
                
            } label: {
                ZStack {
                    Color.clear
                    Image(systemName: imageSystemName)
                        .resizable()
                        .scaledToFit()
                        .padding(innerPadding)
                        .foregroundStyle(.black)
                }
                .background(Color.gray)
                .cornerRadius(30, corners: .allCorners)
            }
        }
    }
}

#Preview {
    FunctionButtonLabel(imageSystemName: "calendar.badge.plus", innerPadding: 10)
}
