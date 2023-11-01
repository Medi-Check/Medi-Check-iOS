//
//  Extension+CGFloat.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/2/23.
//

import SwiftUI

extension CGFloat {
    static func adaptiveSize(portraitIPhone: CGFloat, landscapeIPhone: CGFloat, portraitIPad: CGFloat = 0, landscapeIPad: CGFloat) -> CGFloat {
        if UIDevice.isIPhone {
            if UIDevice.isPortrait {
                return portraitIPhone
            } else {
                return landscapeIPhone
            }
        } else {
            if UIDevice.isPortrait {
                return portraitIPad
            } else {
                return landscapeIPad
            }
        }
    }
}
