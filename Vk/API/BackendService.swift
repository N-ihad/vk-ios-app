//
//  BackendService.swift
//  Vk
//
//  Created by Nihad on 12/26/20.
//

import Foundation

class BackendService {
    static let shared = BackendService()
    var users = [User]()
    var groups = [Group]()
    
    // MARK: - Create
    
    func addUser(user: User) {
        users.append(user)
    }
    
    func addGroup(group: Group) {
        groups.append(group)
    }
    
    // MARK: - Get
    
    func fetchUserFriends(completion: @escaping ([User]) -> Void) {
        NetworkService.shared.getCurrentUserFriends { (response) in
            guard let res = response.value else { return }
            self.users = res.response.items
            completion(self.users)
        }
    }
    
    func fetchUserGroups(completion: @escaping ([Group]) -> Void) {
        NetworkService.shared.getCurrentUserGroups { response in
            guard let res = response.value else { return }
            self.groups = res.response.items
            completion(self.groups)
        }
    }
    
    func fetchGroups(startingWithTitle queryString: String, completion: @escaping ([Group]) -> Void) {
        NetworkService.shared.getGroups(startingWithTitle: queryString) { response in
            guard let res = response.value else { return }
            completion(res.response.items)
        }
    }
    
    func fetchPhotosOfUser(withID userID: String, completion: @escaping ([Photo]) -> Void) {
        NetworkService.shared.getPhotosOfUser(withID: userID) { response in
            guard let res = response.value else { return }
            completion(res.response.items)
        }
    }
    
    private init() { }
}
