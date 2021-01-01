//
//  GroupsVC.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit

class GroupsVC: UIViewController {
    
    // MARK: - Properties
    var groups: [Group]?
    var tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredData = [Group]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate = self
        navigationController?.delegate = self
        
        configureUI()
        fetchUserGroups()
    }
    
    // MARK: - Selectors
    
    @objc func handleGlobalTapped() {
        let globalGroupsVC = GlobalGroupsVC()
        navigationController?.pushViewController(globalGroupsVC, animated: true)
    }
    
    // MARK: - Helpers
    func fetchUserGroups() {
        BackendService.shared.fetchUserGroups { groups in
            self.groups = groups
            self.tableView.reloadData()
        }
    }
    
    func configureUI() {
        navigationItem.title = "Группы"
        
        configureNavigationBar()
        configureSearchBar()
        configureTableView()
    }
    
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Глобальные", style: .plain, target: self, action: #selector(handleGlobalTapped))
        navigationController?.navigationBar.tintColor = .vkBlue
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.rowHeight = 80
        tableView.register(GroupCell.self, forCellReuseIdentifier: "GroupCell")
        tableView.pinTo(view)
        tableView.frame = view.frame
    }
    
    func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.isUserInteractionEnabled = false
        searchController.searchBar.placeholder = "Needs modifying for new data model"
    }
}


extension GroupsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") as! GroupCell
        guard let groups = groups else { return cell }
        let group = groups[indexPath.row]
        cell.set(groupTitle: group.name, groupAvatarURL: URL(string: group.photo50) ?? URL(string: "")!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && !searchController.searchBar.isFirstResponder {
            self.groups?.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension GroupsVC: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filteredData = []
//
//        if searchText == "" {
//            filteredData = groups
//            tableView.reloadData()
//        } else {
//            BackendService.shared.fetchGroups(startingWithTitle: searchText) { groups in
//                print("*** BEFORE PRINT ***")
//                groups.forEach { group in
//                    print(group.name)
//                }
//                print("*** AFTER PRINT ***")
//            }
//            for group in groups {
//                if group.name.lowercased().contains(searchText.lowercased()) {
//                    filteredData.append(group)
//                }
//            }
//        }
//
//        tableView.reloadData()
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.endEditing(true)
//        filteredData = groups
//        tableView.reloadData()
//    }
//
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        filteredData = groups
//    }
}

extension GroupsVC: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            return AnimationControllerForGroups(animationDuration: 1, animationType: .pop)
        default:
            return nil
        }
    }
}
