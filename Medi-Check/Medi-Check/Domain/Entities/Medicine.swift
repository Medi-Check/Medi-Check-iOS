//
//  Medicine.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/8/23.
//

import Foundation

struct Movie: Equatable, Identifiable {
    typealias Identifier = String
    let id: Identifier
    let name: String
    let amount: Int
    let makeDate: String
    let information: String
    let medicineContainer: Int
}
