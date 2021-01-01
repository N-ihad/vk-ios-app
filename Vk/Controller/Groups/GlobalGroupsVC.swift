//
//  GlobalGroupsVC.swift
//  Eigth homework task
//
//  Created by Nihad on 11/17/20.
//

import UIKit

class GlobalGroupsVC: UIViewController {
    
    // MARK: - Properties
    var groups: [Group] = []
    var tableView = UITableView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureGestures()
    }
    
    // MARK: - Selectors
    @objc func handleCancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        navigationItem.title = "Глобальные группы"
        
        configureNavigationBar()
        configureTableView()
    }
    
    func configureGestures() {
        let screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(goBack))
        screenEdgeRecognizer.edges = .left
        view.addGestureRecognizer(screenEdgeRecognizer)
    }
    
    func configureNavigationBar() {
        self.tableView.sectionHeaderHeight = 300
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.rowHeight = 80
        tableView.register(GroupCell.self, forCellReuseIdentifier: "GroupCell")
        tableView.pinTo(view)
    }
}


extension GlobalGroupsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") as! GroupCell
//        let group = groups[indexPath.row]
//        cell.set(group: group)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
//
//        let button = UIButton()
//        button.addTarget(self, action: #selector(handleCancelTapped), for: .touchUpInside)
//        button.setTitle("Cancel", for: .normal)
//        button.setTitleColor(.vkBlue, for: .normal)
//        headerView.addSubview(button)
//        button.centerY(inView: headerView, rightAnchor: headerView.rightAnchor, paddingRight: 12)
//
//        let divider = Utilities().divider(color: .gray)
//        headerView.addSubview(divider)
//        divider.centerX(inView: headerView, topAnchor: headerView.bottomAnchor, paddingTop: 0)
//
//        return headerView
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
}
