//
//  Medicine.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/8/23.
//

import Foundation

struct Medicine: Equatable, Identifiable {
    typealias Identifier = String
    var id: Identifier = ""
    var name: String = ""
    var makeDate: String = ""
    var expirationDate: String = ""
    var amount: Int = 0
    var information: String = ""
    var medicineContainer: Int = 0
    var medicineCost: Int = 0
}
