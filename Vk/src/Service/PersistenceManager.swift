//
//  PersistenceManager.swift
//  Vk
//
//  Created by Nihad on 12/26/20.
//

import Foundation

final class PersistenceManager {

    static let shared = PersistenceManager()

    var users = [User]()
    var groups = [Group]()

    private init() { }

    func addUser(user: User) {
        users.append(user)
    }
    
    func addGroup(group: Group) {
        groups.append(group)
    }

    func getUserFriends(completion: @escaping ([User]) -> Void) {
        VkService.shared.fetchUserFriends { [weak self] response in
            guard let value = response.value,
                  let self = self else {
                return
            }

            self.users = value.response.items
            completion(self.users)
        }
    }
    
    func getUserGroups(completion: @escaping ([Group]) -> Void) {
        VkService.shared.fetchUserGroups { [weak self] response in
            guard let value = response.value,
                  let self = self else {
                return
            }

            self.groups = value.response.items
            completion(self.groups)
        }
    }

    func getGroups(startingWithTitle queryString: String, completion: @escaping ([Group]) -> Void) {
        VkService.shared.fetchGroups(startingWithTitle: queryString) { response in
            guard let value = response.value else { return }
            completion(value.response.items)
        }
    }

    func getUserPhotos(withUserId userId: String, completion: @escaping ([Photo]) -> Void) {
        VkService.shared.fetchUserPhotos(withID: userId) { response in
            guard let value = response.value else { return }
            completion(value.response.items)
        }
    }
}
