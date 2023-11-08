//
//  Member.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 10/28/23.
//

import Foundation

struct Member: Equatable, Identifiable {
    typealias Identifier = String
    let id: Identifier
    let nickname: String
    let familyCode: String
    let profileImage: String
    
}
