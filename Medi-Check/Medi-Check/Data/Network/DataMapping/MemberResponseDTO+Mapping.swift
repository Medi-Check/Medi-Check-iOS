//
//  MemberResponseDTO+Mapping.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/7/23.
//

import Foundation

struct MemberResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case nickname = "nick_name"
        case familyCode = "family_code"
    }
    let nickname: String
    let familyCode: String
}
