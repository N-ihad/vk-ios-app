//
//  FriendsVC.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit
import Kingfisher

class FriendsVC: UIViewController {
    
    // MARK: - Properties
    var tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredData = [User]()
    let loadingOverlay = Utilities().loadingView()
    
    var friends: [User] = []
    var sortedFirstLetters: [String] = []
    var sections: [[User]] = [[]]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureNavigationBar()
        configureSearchBar()
        configureTableView()
        configureUI()
        fetchUserFriends()
    }
    
    // MARK: - Selectors
    
    @objc func handleLoadingTapped(_ sender: UIBarButtonItem) {
        startLoadingAnimation()
    }
    
    // MARK: - Helpers
    
    func configureSections() {
        let firstLetters = friends.map { $0.titleFirstLetter }
        let uniqueFirstLetters = Array(Set(firstLetters))

        sortedFirstLetters = uniqueFirstLetters.sorted()
        sections = sortedFirstLetters.map { firstLetter in
            return friends
                .filter { $0.titleFirstLetter == firstLetter }
                .sorted { $0.lastName < $1.lastName }
        }
    }
    
    func fetchUserFriends() {
        startLoadingAnimation()
        BackendService.shared.fetchUserFriends { users in
            self.friends = users
            self.configureSections()
            self.tableView.reloadData()
            self.stopLoadingAnimation()
        }
    }
    
    func configureUI() {
        tableView.sectionIndexColor = .vkBlue
        transitioningDelegate = self
        navigationController?.delegate = self
    }
    
    func configureNavigationBar() {
        let imageView = UIImageView(image: UIImage(named: "vk-logo"))
        imageView.contentMode = .scaleAspectFit
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        navigationItem.titleView = titleView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "dot.circle.and.cursorarrow"), style: .plain, target: self, action: #selector(handleLoadingTapped))
        navigationController?.navigationBar.tintColor = .vkBlue
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.rowHeight = 80
        tableView.register(FriendCell.self, forCellReuseIdentifier: "FriendCell")
        tableView.pinTo(view)
    }
    
    func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.isUserInteractionEnabled = false
        searchController.searchBar.placeholder = "Needs modifying for new data model"
    }
    
    func startLoadingAnimation() {
        view.addSubview(loadingOverlay)
        loadingOverlay.pinTo(view)
    }
    
    func stopLoadingAnimation() {
        loadingOverlay.removeFromSuperview()
    }
}

// MARK: - TableView

extension FriendsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
//        return searchController.searchBar.isFirstResponder ? 1 : User.alphabeticDictionaryOfUsersLastnames.keys.count
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return searchController.searchBar.isFirstResponder ? filteredData.count : User.alphabeticDictionaryOfUsersLastnames.getUsersByIndex(key: section).count
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return searchController.searchBar.isFirstResponder ? "Found" : User.alphabeticDictionaryOfUsersLastnames.keys[section]
        guard !sortedFirstLetters.isEmpty else { return "Loading.." } // sortedFirstLetters is empty
        return searchController.searchBar.isFirstResponder ? "Search is yet to be developed" : sortedFirstLetters[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as! FriendCell
//        var user: User!
//        if searchController.searchBar.isFirstResponder {
//            user = filteredData[indexPath.row]
//        } else {
//            user = User.alphabeticDictionaryOfUsersLastnames.getUsersByIndex(key: indexPath.section)[indexPath.row]
//        }
        let user = sections[indexPath.section][indexPath.row]
        cell.set(username: user.firstName + " " + user.lastName, userAvatarURL: URL(string: user.photo100) ?? URL(string: "")!)
        cell.delegate = self
        
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sortedFirstLetters
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friendDetailsCollectionVC = FriendDetailsCollectionVC()
        friendDetailsCollectionVC.user = sections[indexPath.section][indexPath.row]
        navigationController?.pushViewController(friendDetailsCollectionVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SearchController

extension FriendsVC: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filteredData = []
//
//        if searchText == "" {
//            filteredData = User.allUsersSortedByName
//            tableView.reloadData()
//        } else {
//            for user in User.allUsersSortedByName {
//                if user.name.lowercased().contains(searchText.lowercased()) {
//                    filteredData.append(user)
//                }
//            }
//        }
//
//        tableView.reloadData()
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.endEditing(true)
//        filteredData = []
//        tableView.reloadData()
//    }
//
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        filteredData = []
//    }
}

// MARK: - Friend Cell Delegate Methods

extension FriendsVC: FriendCellDelegate {
    func handleLikeTapped(_ cell: FriendCell) {
        
    }
    
    func handleFavouriteTapped(_ cell: FriendCell) {
        
    }
    
    func handleFriendAvatarTapped(_ cell: FriendCell) {
        
    }
}

// MARK: - Transition

extension FriendsVC: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return AnimationController(animationDuration: 1, animationType: .push)
        case .pop:
            return AnimationController(animationDuration: 1, animationType: .pop)
        default:
            return nil
        }
    }
}
