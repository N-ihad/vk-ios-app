//
//  FriendPhotosCell.swift
//  Eigth_homework_task
//
//  Created by Nihad on 11/23/20.
//

import UIKit

class FriendPhotosCell: UICollectionViewCell {
    // MARK: - Properties
    var photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        contentView.addSubview(photoImageView)
//        photoImageView.pinTo(contentView)
        photoImageView.centerY(inView: contentView)
        photoImageView.anchor(left: contentView.leftAnchor, right: contentView.rightAnchor, paddingLeft: 0, paddingRight: 0)
    }
}
