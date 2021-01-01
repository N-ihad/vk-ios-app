//
//  NewsVC.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit

let descr = "asdfasdfa ksdmflka msdlkfma lskdmfl akmsdlfkm alsdmfl amsdlkfm alskdmfl askmdlf masldkfm laskdmfl amsdlf masl asmdflk amsldkmf laskmdfl kamsdlkfm aslkdmf"

class NewsVC: UIViewController {
    
    // MARK: - Properties
//    var posts: [Post] = [Post(poster: user, description: descr, image: UIImage(named: "testAvatar1")!),
//                         Post(poster: group, description: descr, image: UIImage(named: "testAvatar")!),]
    var posts: [Post] = []
    var tableView = UITableView()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    func configureUI() {
        navigationItem.title = "Новости"
        
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.pinTo(view)
    }
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        cell.set(post: post)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 570
    }
}
