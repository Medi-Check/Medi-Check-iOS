//
//  ScheduleView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/6/23.
//

import SwiftUI

struct ScheduleView: View {
    var body: some View {
        GeometryReader { geometry in
            let geoWidth = geometry.size.width
            let geoHeight = geometry.size.height
            ZStack {
                SecondBackgroundView()
                HStack(spacing: geoWidth * 0.1) {
                    VStack(spacing: 20) {
                        FunctionButtonLabel(imageSystemName: "calendar.badge.plus", innerPadding: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.05, landscapeIPhone: geoWidth * 0.04, portraitIPad: geoWidth * 0.05, landscapeIPad: geoWidth * 0.04))
                            .frame(width: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.4, landscapeIPhone: geoWidth * 0.3, portraitIPad: geoWidth * 0.4, landscapeIPad: geoWidth * 0.3), height: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.4, landscapeIPhone: geoWidth * 0.3, portraitIPad: geoWidth * 0.4, landscapeIPad: geoWidth * 0.3))
                        Text("일정 등록")
                            .font(.system(size: CGFloat.adaptiveSize(portraitIPhone: 20, landscapeIPhone: 20, portraitIPad: 40, landscapeIPad: 40), weight: .bold))
                    }
                    
                    VStack(spacing: 20) {
                        FunctionButtonLabel(imageSystemName: "calendar.badge.checkmark", innerPadding: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.05, landscapeIPhone: geoWidth * 0.04, portraitIPad: geoWidth * 0.05, landscapeIPad: geoWidth * 0.04))
                            .frame(width: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.4, landscapeIPhone: geoWidth * 0.3, portraitIPad: geoWidth * 0.4, landscapeIPad: geoWidth * 0.3), height: CGFloat.adaptiveSize(portraitIPhone: geoWidth * 0.4, landscapeIPhone: geoWidth * 0.3, portraitIPad: geoWidth * 0.4, landscapeIPad: geoWidth * 0.3))
                        
                        Text("약 정보 등록")
                            .font(.system(size: CGFloat.adaptiveSize(portraitIPhone: 20, landscapeIPhone: 20, portraitIPad: 40, landscapeIPad: 40), weight: .bold))
                    }
                }
                
            }
        }
    }
}

#Preview {
    ScheduleView()
}
