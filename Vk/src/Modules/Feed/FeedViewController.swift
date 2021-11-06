//
//  FeedViewController.swift
//
//  Created by Nihad on 11/16/20.
//

import UIKit

private let mockDescription = "asdfasdfa ksdmflka msdlkfma lskdmfl akmsdlfkm alsdmfl amsdlkfm alskdmfl askmdlf masldkfm laskdmfl amsdlf masl asmdflk amsldkmf laskmdfl kamsdlkfm aslkdmf"

final class FeedViewController: UIViewController {

//    var mockPosts: [Post] = [
//        Post(poster: user, description: descr, image: UIImage(named: "testAvatar1")!),
//        Post(poster: group, description: descr, image: UIImage(named: "testAvatar")!),
//    ]
    private var posts: [Post] = []

    private let identifier = "PostCell"
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layout()
    }

    private func setup() {
        navigationItem.title = "Новости"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: identifier)
    }

    private func layout() {
        view.addSubview(tableView)
        tableView.pinTo(view)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! FeedTableViewCell
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
