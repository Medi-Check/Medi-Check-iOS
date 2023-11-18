//
//  TakeMedicineRes.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/19/23.
//

import Foundation

enum Week: String, Codable {
    case MONDAY
    case TUESDAY
    case WEDNESDAY
    case THURSDAY
    case FRIDAY
    case SATURDAY
    case SUNDAT
}

struct TakeMedicineRes: Equatable, Identifiable {
    typealias Identifier = String
    let id: Identifier
    let medicineName: String
    let takeMedicineId: Int
    let week: [Week]
    let hour: Int
    let minute: Int
    let amounts: Int
}


