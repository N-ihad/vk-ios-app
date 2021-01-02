//
//  UserNew.swift
//  Vk
//
//  Created by Nihad on 12/24/20.
//

import Foundation

struct UsersResponse: Decodable {
    let response: Users
}

struct Users: Decodable {
    let count: Int
    let items: [User]

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case items = "items"
    }
}


struct User: Decodable {
    let firstName: String
    let online: Int
    let id: Int
    let lastName: String
    let photo50, photo100, photo200_Orig: String
    let trackCode: String
    let deactivated: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case online
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200_Orig = "photo_200_orig"
        case trackCode = "track_code"
        case deactivated
    }
}


extension User {
    var titleFirstLetter: String {
        return String(self.lastName[self.lastName.startIndex]).uppercased()
    }
}
