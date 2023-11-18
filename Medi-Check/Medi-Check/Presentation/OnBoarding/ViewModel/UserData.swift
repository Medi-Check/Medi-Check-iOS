//
//  UserData.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 10/28/23.
//

import Foundation

class UserData: ObservableObject {
    @Published var currnetProfile: Member = Member()
    @Published var familyCode: String = ""
    @Published var members: [Member] = []
    
    static func getMembersDtoToMembers(members: [InputFamilyCodeViewModel.getMembersDTO]) -> [Member] {
        return members.map { dtoMember -> Member in
            var member = Member()
            member.nickName = dtoMember.nickName
            member.profileImage = dtoMember.imgUrl
            return member
        }
    }
    
    
}
