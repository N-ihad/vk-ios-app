//
//  GroupsTableViewCell.swift
//
//  Created by Nihad on 11/17/20.
//

import UIKit

final class GroupsTableViewCell: UITableViewCell {

    private let groupImageView: UIImageView = {
        let groupImageView = UIImageView()
        groupImageView.contentMode = .scaleAspectFit
        groupImageView.clipsToBounds = true
        groupImageView.setDimensions(width: 48, height: 48)
        groupImageView.layer.cornerRadius = 48 / 2
        groupImageView.backgroundColor = .themeBlue
        groupImageView.isUserInteractionEnabled = true
        return groupImageView
    }()
    
    private let groupTitleLabel: UILabel = {
        let groupTitleLabel = UILabel()
        let width = UIScreen.main.bounds.width / 2
        groupTitleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        return groupTitleLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    private func setup() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleAvatarTapped))
        groupImageView.addGestureRecognizer(gesture)
    }

    private func layout() {
        contentView.addSubview(groupImageView)
        groupImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 16)

        contentView.addSubview(groupTitleLabel)
        groupTitleLabel.centerY(inView: self, leftAnchor: groupImageView.rightAnchor, paddingLeft: 8)
    }

    @objc private func handleAvatarTapped() {
        Helper.animate(view: groupImageView)
    }
    
    func set(groupTitle: String, groupAvatarURL: URL) {
        groupImageView.kf.setImage(with: groupAvatarURL)
        groupTitleLabel.text = groupTitle
    }
}
