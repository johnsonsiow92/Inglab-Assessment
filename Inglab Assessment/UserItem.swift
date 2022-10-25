//
//  UserItem.swift
//  Inglab Assessment
//
//  Created by The Lorry Online on 24/10/2022.
//

import Foundation

struct UserItem: Identifiable, Codable, Comparable {
    static func < (lhs: UserItem, rhs: UserItem) -> Bool {
        if lhs.index < rhs.index {
            return true
        } else {
            return false
        }
    }
    
    let id: Int
    let index: Int
    let avatar: String
    let name: String
    let phone: String
    let email: String
    let description: String
    let isActive: Bool
}
