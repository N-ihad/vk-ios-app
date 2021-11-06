//
//  FriendCellDetailsCollectionVC.swift
//  Eigth homework task
//
//  Created by Nihad on 11/17/20.
//

import UIKit

final class FriendPhotosCollectionViewController: UICollectionViewController {

    private let reuseIdentifier = "Cell"

    private var photos: [Photo]? {
        didSet {
            collectionView.reloadData()
        }
    }

    var user: User? {
        didSet {
            guard let user = user else { return }
            fetchPhotosOfUser(withId: String(user.id))
        }
    }

    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = collectionView.frame.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        collectionView?.setCollectionViewLayout(layout, animated: true)

        collectionView.register(FriendPhotosCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.isPagingEnabled = true
    }
    
    private func fetchPhotosOfUser(withId userId: String) {
        PersistenceManager.shared.getUserPhotos(withUserId: userId) { [weak self] photos in
            self?.photos = photos
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension FriendPhotosCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendPhotosCollectionViewCell

        guard let photos = photos,
              let photoStringUrl = photos[indexPath.row].photo604,
              let url = URL(string: photoStringUrl) else {
            return cell
        }

        cell.set(imageWith: url)

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 willDisplay cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        UIView.animate(
            withDuration: 1.0,
            animations: {
                cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        )
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FriendPhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: view.frame.height - (view.safeAreaInsets.top + view.safeAreaInsets.bottom))
    }
}
