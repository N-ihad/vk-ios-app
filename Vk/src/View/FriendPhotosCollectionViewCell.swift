//
//  FriendPhotosCell.swift
//  Eigth_homework_task
//
//  Created by Nihad on 11/23/20.
//

import UIKit

final class FriendPhotosCollectionViewCell: UICollectionViewCell {

    private var photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.contentMode = .scaleAspectFit
        return photoImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    private func style() {
        contentView.addSubview(photoImageView)
        photoImageView.centerY(inView: contentView)
        photoImageView.anchor(left: contentView.leftAnchor, right: contentView.rightAnchor)
    }

    func set(imageWith url: URL) {
        photoImageView.kf.setImage(with: url)
    }
}
