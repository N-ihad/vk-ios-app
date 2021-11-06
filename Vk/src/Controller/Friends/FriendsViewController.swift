//
//  FriendsViewController.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit
import Kingfisher

final class FriendsViewController: UIViewController {

    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let loadingOverlay = Utilities.makeLoadingView()

    private var filteredData = [User]()
    private var friends: [User] = []
    private var sortedFirstLetters: [String] = []
    private var sections: [[User]] = [[]]

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layout()
        fetchUserFriends()
    }

    private func setup() {
        tableView.sectionIndexColor = .themeBlue
        transitioningDelegate = self
        navigationController?.delegate = self

        let imageView = UIImageView(image: UIImage(named: "vk-logo"))
        imageView.contentMode = .scaleAspectFit

        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        navigationItem.titleView = titleView
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "dot.circle.and.cursorarrow"),
            style: .plain,
            target: self,
            action: #selector(onLoadingTap)
        )
        navigationController?.navigationBar.tintColor = .themeBlue

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.isUserInteractionEnabled = false
        searchController.searchBar.placeholder = "Needs modifying for new data model"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.register(FriendsCollectionViewCell.self, forCellReuseIdentifier: "FriendCell")
    }

    private func layout() {
        view.addSubview(tableView)
        tableView.pinTo(view)
    }

    @objc private func onLoadingTap(_ sender: UIBarButtonItem) {
        startLoadingAnimation()
    }
    
    // MARK: - API
    private func fetchUserFriends() {
        startLoadingAnimation()
        PersistenceManager.shared.getUserFriends { [weak self] users in
            self?.friends = users
            self?.configureSections()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.stopLoadingAnimation()
            }
        }
    }

    private func configureSections() {
        let firstLetters = friends.map { $0.titleFirstLetter }
        let uniqueFirstLetters = Array(Set(firstLetters))

        sortedFirstLetters = uniqueFirstLetters.sorted()
        sections = sortedFirstLetters.map { firstLetter in
            return friends
                .filter { $0.titleFirstLetter == firstLetter }
                .sorted { $0.lastName < $1.lastName }
        }
    }
    
    private func startLoadingAnimation() {
        view.addSubview(loadingOverlay)
        loadingOverlay.pinTo(view)
    }
    
    private func stopLoadingAnimation() {
        loadingOverlay.removeFromSuperview()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
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
        guard !sortedFirstLetters.isEmpty else { return "Loading.." }
        return searchController.searchBar.isFirstResponder ? "Search is yet to be developed" : sortedFirstLetters[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as! FriendsCollectionViewCell
//        var user: User!
//        if searchController.searchBar.isFirstResponder {
//            user = filteredData[indexPath.row]
//        } else {
//            user = User.alphabeticDictionaryOfUsersLastnames.getUsersByIndex(key: indexPath.section)[indexPath.row]
//        }
        let user = sections[indexPath.section][indexPath.row]
        cell.set(
            username: user.firstName + " " + user.lastName,
            userAvatarURL: URL(string: user.photo100) ?? URL(string: "")!,
            isOnline: user.online != 0
        )
        
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sortedFirstLetters
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friendDetailsCollectionVC = FriendPhotosCollectionViewController()
        friendDetailsCollectionVC.user = sections[indexPath.section][indexPath.row]
        navigationController?.pushViewController(friendDetailsCollectionVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension FriendsViewController: UISearchBarDelegate {
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

// MARK: - UIViewControllerTransitioningDelegate, UINavigationControllerDelegate
extension FriendsViewController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
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
