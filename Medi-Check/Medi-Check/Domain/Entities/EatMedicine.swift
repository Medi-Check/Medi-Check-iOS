//
//  EatMedicine.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/8/23.
//

import Foundation

struct EatMedicine: Equatable, Identifiable {
    typealias Identifier = String
    let id: Identifier
    let checked: Bool
}
