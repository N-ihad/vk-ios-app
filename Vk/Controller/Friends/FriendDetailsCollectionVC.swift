//
//  FriendCellDetailsCollectionVC.swift
//  Eigth homework task
//
//  Created by Nihad on 11/17/20.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendDetailsCollectionVC: UICollectionViewController {
    // MARK: - Properties
    
    var user: User? {
        didSet {
            guard let user = user else { return }
            fetchPhotosOfUser(withID: String(user.id))
            
        }
    }
    var photos: [Photo]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = collectionView.frame.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        self.collectionView?.setCollectionViewLayout(layout, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func fetchPhotosOfUser(withID userID: String) {
        BackendService.shared.fetchPhotosOfUser(withID: userID) { photos in
            self.photos = photos
        }
    }
    
    func configureUI() {
        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView!.register(FriendPhotosCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.isPagingEnabled = true
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendPhotosCell
        guard let photos = photos else { return cell }
        cell.photoImageView.kf.setImage(with: URL(string: photos[indexPath.row].photo604!))
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let newCell = cell as? FriendPhotosCell {
            newCell.photoImageView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            UIView.animate(withDuration: 1.0, animations: {() -> Void in
                newCell.photoImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
    }
}


extension FriendDetailsCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: view.frame.height - (view.safeAreaInsets.top + view.safeAreaInsets.bottom))
    }
}
