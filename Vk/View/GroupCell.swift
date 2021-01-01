//
//  GroupTableViewCell.swift
//  Eigth homework task
//
//  Created by Nihad on 11/17/20.
//

import UIKit

class GroupCell: UITableViewCell {
    // MARK: - Properties
    let groupImageView: UIImageView = {
        let groupImageView = UIImageView()
        groupImageView.contentMode = .scaleAspectFit
        groupImageView.clipsToBounds = true
        groupImageView.setDimensions(width: 48, height: 48)
        groupImageView.layer.cornerRadius = 48 / 2
        groupImageView.backgroundColor = .vkBlue
        groupImageView.isUserInteractionEnabled = true
        
        return groupImageView
    }()
    
    private let groupTitleLabel: UILabel = {
        let groupTitleLabel = UILabel()
        groupTitleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2).isActive = true
        
        return groupTitleLabel
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        configureGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func handleAvatarTapped() {
        Utilities().animate(viewToAnimate: groupImageView)
    }
    
    // MARK: - Helpers
    func configureUI() {
        self.contentView.addSubview(groupImageView)
        self.contentView.addSubview(groupTitleLabel)
        groupImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 16)
        groupTitleLabel.centerY(inView: self, leftAnchor: groupImageView.rightAnchor, paddingLeft: 8)
    }
    
    func configureGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleAvatarTapped))
        self.groupImageView.addGestureRecognizer(gesture)
    }
    
    func set(groupTitle: String, groupAvatarURL: URL) {
        groupImageView.kf.setImage(with: groupAvatarURL)
        groupTitleLabel.text = groupTitle
    }
}
