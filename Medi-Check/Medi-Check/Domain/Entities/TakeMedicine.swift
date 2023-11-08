//
//  TakeMedicine.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/8/23.
//

import Foundation

struct TakeMedicine: Equatable, Identifiable {
    typealias Identifier = String
    let id: Identifier
    let userId: String
    let medicineId: Int
    let week: String
    let time: String
    let amounts: Int
}
