//
//  Photo.swift
//  Vk
//
//  Created by Nihad on 12/25/20.
//

import Foundation

struct PhotosResponse: Decodable {
    let response: Photos
}

struct Photos: Decodable {
    let count: Int
    let items: [Photo]

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case items = "items"
    }
}

struct Photo: Decodable {
    let albumID, date, id, ownerID: Int
    let hasTags: Bool
    let height: Int
    let photo1280, photo130, photo604, photo75: String?
    let photo807: String?
    let postID: Int?
    let text: String
    let width: Int
    let photo2560: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case height
        case photo1280 = "photo_1280"
        case photo130 = "photo_130"
        case photo604 = "photo_604"
        case photo75 = "photo_75"
        case photo807 = "photo_807"
        case postID = "post_id"
        case text, width
        case photo2560 = "photo_2560"
    }
}
