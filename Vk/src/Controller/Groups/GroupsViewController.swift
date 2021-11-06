//
//  GroupsVC.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit

final class GroupsViewController: UIViewController {

    private let identifier = "GroupCell"
    private let searchController = UISearchController(searchResultsController: nil)

    private var groups: [Group]?
    private var filteredData = [Group]()

    private var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        fetchUserGroups()
    }

    private func setup() {
        transitioningDelegate = self
        navigationController?.delegate = self

        navigationItem.title = "Группы"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Глобальные",
            style: .plain,
            target: self,
            action: #selector(onOpenGlobalGroups)
        )
        navigationController?.navigationBar.tintColor = .themeBlue
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.isUserInteractionEnabled = false
        searchController.searchBar.placeholder = "Needs modifying for new data model"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: identifier)
    }

    private func layout() {
        view.addSubview(tableView)
        tableView.pinTo(view)
    }

    @objc private func onOpenGlobalGroups() {
        let globalGroupsVC = GlobalGroupsViewController()
        navigationController?.pushViewController(globalGroupsVC, animated: true)
    }

    // MARK: - API
    private func fetchUserGroups() {
        PersistenceManager.shared.getUserGroups { [weak self] groups in
            self?.groups = groups
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") as! GroupTableViewCell

        guard let groups = groups,
              let url = URL(string: groups[indexPath.row].photo50) else {
            return cell
        }

        cell.set(groupTitle: groups[indexPath.row].name, groupAvatarURL: url)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && !searchController.searchBar.isFirstResponder {
            groups?.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - UIViewControllerTransitioningDelegate, UINavigationControllerDelegate
extension GroupsViewController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            return AnimationControllerForGroups(animationDuration: 1, animationType: .pop)
        default:
            return nil
        }
    }
}

// MARK: - UISearchBarDelegate
extension GroupsViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filteredData = []
//
//        if searchText == "" {
//            filteredData = groups
//            tableView.reloadData()
//        } else {
//            PersistenceManager.shared.fetchGroups(startingWithTitle: searchText) { groups in
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
