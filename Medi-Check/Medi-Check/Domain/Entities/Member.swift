//
//  Member.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 10/28/23.
//

import Foundation

struct Member: Equatable, Identifiable {
    typealias Identifier = String
    var id: Identifier = ""
    var nickName: String = ""
    var familyCode: String = ""
    var profileImage: String = "Profile"
    
}
