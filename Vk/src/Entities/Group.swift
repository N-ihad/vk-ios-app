//
//  GroupNew.swift
//  Vk
//
//  Created by Nihad on 12/25/20.
//

import Foundation

struct GroupsResponse: Decodable {
    let response: Groups
}

struct Groups: Decodable {

    let count: Int
    let items: [Group]

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case items = "items"
    }
}

struct Group: Decodable {

    let id: Int
    let name, screenName: String
    let isClosed: Int
    let type: String
    let isAdmin, isMember, isAdvertiser: Int
    let photo50, photo100, photo200: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}
