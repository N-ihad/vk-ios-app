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
        NetworkService.shared.getCurrentUserFriends { [weak self] (response) in
            guard let res = response.value else { return }
            guard let strongSelf = self else { return }
            
            strongSelf.users = res.response.items
            completion(strongSelf.users)
        }
    }
    
    func fetchUserGroups(completion: @escaping ([Group]) -> Void) {
        NetworkService.shared.getCurrentUserGroups { [weak self] response in
            guard let res = response.value else { return }
            guard let strongSelf = self else { return }
            
            strongSelf.groups = res.response.items
            completion(strongSelf.groups)
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
