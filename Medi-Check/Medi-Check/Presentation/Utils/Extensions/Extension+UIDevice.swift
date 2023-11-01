//
//  Extension+UIDevice.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/2/23.
//

import SwiftUI

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    static var isPortrait: Bool {
        UIDevice.current.orientation == .portrait
    }
    
    static var isLandscape: Bool {
        (UIDevice.current.orientation == .landscapeLeft) || (UIDevice.current.orientation == .landscapeRight)
    }
}
