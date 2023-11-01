//
//  BasicButton.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 10/31/23.
//

import SwiftUI

struct BasicButtonLabel: View {
    let text: String
    let strokeWidth: CGFloat
    let fontSize: CGFloat
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
                StrokeText(text: text, width: strokeWidth, color: Color.black)
                    .foregroundColor(.white)
                    .font(.system(size: fontSize, weight: .bold))
                    .frame(width: width, height: height, alignment: .center)
    }
}

#Preview {
    BasicButtonLabel(text: "완료", strokeWidth: 1, fontSize: 40, width: 400, height: 60)
}
