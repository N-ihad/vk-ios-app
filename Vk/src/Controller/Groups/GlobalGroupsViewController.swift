//
//  GlobalGroupsVC.swift
//  Eigth homework task
//
//  Created by Nihad on 11/17/20.
//

import UIKit

final class GlobalGroupsViewController: UIViewController {

    private let identifier = "GroupCell"
    private var groups: [Group] = []
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
    }

    private func setup() {
        navigationItem.title = "Глобальные группы"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.sectionHeaderHeight = 300
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: identifier)

        let screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(onBack))
        screenEdgeRecognizer.edges = .left
        view.addGestureRecognizer(screenEdgeRecognizer)
    }

    private func layout() {
        view.addSubview(tableView)
        tableView.pinTo(view)
    }

    @objc private func handleCancelTapped() {
        dismiss(animated: true)
    }

    @objc private func onBack() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension GlobalGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: identifier) as! GroupTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
