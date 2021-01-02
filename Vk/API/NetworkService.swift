//
//  NetworkService.swift
//  Vk
//
//  Created by Nihad on 12/24/20.
//

import Foundation
import Alamofire
import SwiftyJSON


class NetworkService {
    static let shared = NetworkService()
    private var session = Session() {
        didSet {
            defaultParameters["user_id"] = session.userID
            defaultParameters["access_token"] = session.token
        }
    }
    private var defaultParameters: [String : Any] = [
        "v": 5.28
    ]
    
    // MARK: - Creation
    
    func setSession(with token: String, and userID: String) {
        session.token = token
        session.userID = userID
    }
    
    private init() { }
    
    // MARK: - Read
    
    func getCurrentUserID() -> String {
        return session.userID
    }
    
    func getCurrentUserFriends(completion: @escaping ((DataResponse<UsersResponse, AFError>) -> Void)) {
        var params = defaultParameters
        params["fields"] = "photo_50,photo_100,photo_200_orig,online"
        AF.request(API_URLs.getFriends, parameters: params).responseDecodable(of: UsersResponse.self, completionHandler: completion)
    }
    
//    func getProfileOfUser(withID userID: String, completion: @escaping (AFDataResponse<Any>) -> Void) {
//        var params = defaultParameters
//        params["user_id"] = userID
//        params["fields"] = ["photo,photo_medium,photo_big"]
//        let request = AF.request(API_URLs.getProfileOfUser, parameters: params)
//        request.responseJSON { (data) in
//            print(data)
//        }
//        request.responseDecodable(of: UserNew.self) { (response) in
//            guard let userNew = response.value else { return }
//            print(userNew.firstName)
//        }
//        request.responseJSON(completionHandler: completion)
//    }
    
    func getPhotosOfUser(withID userID: String, completion: @escaping ((DataResponse<PhotosResponse, AFError>) -> Void)) {
        var params = defaultParameters
        params["user_id"] = nil
        params["owner_id"] = userID
        params["album_id"] = "profile"
        params["rev"] = 1
        AF.request(API_URLs.getPhotosOfUser, parameters: params).responseDecodable(of: PhotosResponse.self, completionHandler: completion)
    }
    
    func getCurrentUserGroups(completion: @escaping ((DataResponse<GroupsResponse, AFError>) -> Void)) {
        var params = defaultParameters
        params["extended"] = 1
        AF.request(API_URLs.getGroups, parameters: params).responseDecodable(of: GroupsResponse.self, completionHandler: completion)
    }

    func getGroups(startingWithTitle queryString: String, completion: @escaping ((DataResponse<GroupsResponse, AFError>) -> Void)) {
        var params = defaultParameters
        params["user_id"] = nil
        params["q"] = queryString
        AF.request(API_URLs.getGroupsWithName, parameters: params).responseDecodable(of: GroupsResponse.self, completionHandler: completion)
    }
    
    
    
    // MARK: - Update
    
    // MARK: - Delete
}


extension NetworkService {
    
    private struct Session {
        var token: String = ""
        var userID: String = ""
    }
    
}

extension NetworkService {
    
    private struct API_URLs {
        static let getProfileOfUser = "https://api.vk.com/method/users.get"
        static let getFriends = "https://api.vk.com/method/friends.get"
        static let getPhotosOfUser = "https://api.vk.com/method/photos.get"
        static let getGroups = "https://api.vk.com/method/groups.get"
        static let getGroupsWithName = "https://api.vk.com/method/groups.search"
        
        private init() { }
    }
    
}
