//
//  NetworkService.swift
//  Vk
//
//  Created by Nihad on 12/24/20.
//

import Foundation
import Alamofire
import SwiftyJSON

final class VkService {

    private struct Session {
        var token: String = ""
        var userId: String = ""
    }

    static let shared = VkService()

    private var session = Session() {
        didSet {
            defaultParameters["user_id"] = session.userId
            defaultParameters["access_token"] = session.token
        }
    }

    private var defaultParameters: [String : Any] = [
        "v": 5.28
    ]

    private init() { }

    func setSession(with token: String, and userID: String) {
        session.token = token
        session.userId = userID
    }
    
    func fetchUserFriends(completion: @escaping ((DataResponse<UsersResponse, AFError>) -> Void)) {
        var params = defaultParameters
        params["fields"] = "photo_50,photo_100,photo_200_orig,online"
        AF.request(Endpoint.friends, parameters: params).responseDecodable(of: UsersResponse.self, completionHandler: completion)
    }
    
    func fetchUserPhotos(withID userID: String, completion: @escaping ((DataResponse<PhotosResponse, AFError>) -> Void)) {
        var params = defaultParameters
        params["user_id"] = nil
        params["owner_id"] = userID
        params["album_id"] = "profile"
        params["rev"] = 1
        AF.request(Endpoint.userPhotos, parameters: params).responseDecodable(of: PhotosResponse.self, completionHandler: completion)
    }
    
    func fetchUserGroups(completion: @escaping ((DataResponse<GroupsResponse, AFError>) -> Void)) {
        var params = defaultParameters
        params["extended"] = 1
        AF.request(Endpoint.groups, parameters: params).responseDecodable(of: GroupsResponse.self, completionHandler: completion)
    }

    func fetchGroups(startingWithTitle queryString: String, completion: @escaping ((DataResponse<GroupsResponse, AFError>) -> Void)) {
        var params = defaultParameters
        params["user_id"] = nil
        params["q"] = queryString
        AF.request(Endpoint.groupsWithSearchQuery, parameters: params).responseDecodable(of: GroupsResponse.self, completionHandler: completion)
    }
}

// MARK: - VK API endpoints
extension VkService {
    private struct Endpoint {
        static let profile = "https://api.vk.com/method/users.get"
        static let friends = "https://api.vk.com/method/friends.get"
        static let userPhotos = "https://api.vk.com/method/photos.get"
        static let groups = "https://api.vk.com/method/groups.get"
        static let groupsWithSearchQuery = "https://api.vk.com/method/groups.search"
    }
}
