//
//  FriendCell.swift
//
//  Created by Nihad on 11/16/20.
//

import UIKit

protocol FriendsCollectionViewCellDelegate: AnyObject {
    func friendsCollectionViewCellDidReceiveLikeTap(_ cell: FriendsCollectionViewCell)
    func friendsCollectionViewCellDidReceiveFavoriteTap(_ cell: FriendsCollectionViewCell)
    func friendsCollectionViewCellDidReceiveAvatarTap(_ cell: FriendsCollectionViewCell)
}

final class FriendsCollectionViewCell: UITableViewCell {

    weak var delegate: FriendsCollectionViewCellDelegate?

    private let friendAvatarImageView: UIImageView = {
        let friendAvatarImageView = UIImageView()
        friendAvatarImageView.contentMode = .scaleAspectFit
        friendAvatarImageView.clipsToBounds = true
        friendAvatarImageView.setDimensions(width: 48, height: 48)
        friendAvatarImageView.layer.cornerRadius = 48 / 2
        friendAvatarImageView.backgroundColor = .themeBlue
        return friendAvatarImageView
    }()
    
    private let friendAvatarView: UIView = {
        let containerView = UIView()
        containerView.setDimensions(width: 48, height: 48)
        containerView.backgroundColor = .clear
        
        let shadowView = UIView()
        shadowView.setDimensions(width: 48, height: 48)
        shadowView.layer.cornerRadius = 48 / 2
        shadowView.backgroundColor = .themeBlue
        shadowView.dropShadow()
        containerView.addSubview(shadowView)
        
        return containerView
    }()
    
    private let friendNameLabel = UILabel()
    
    private let onlineIndicator: UIView = {
        let onlineIndicator = UIView()
        onlineIndicator.setDimensions(width: 12, height: 12)
        onlineIndicator.backgroundColor = .themeBlueLight
        onlineIndicator.layer.cornerRadius = 12 / 2
        onlineIndicator.isHidden = true
        return onlineIndicator
    }()
    
    private let likeCounterLabel: UILabel = {
        let likeCounterLabel = UILabel()
        likeCounterLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 20)
        likeCounterLabel.text = "0"
        return likeCounterLabel
    }()
    
    private lazy var favoriteButton: UIButton = {
        let favoriteButton = Helper.makeButton(
            with: .themeBlue,
            imgForNormalState: .star,
            imgForSelectedState: .starFilled,
            width: 35,
            height: 30
        )
        favoriteButton.addTarget(self, action: #selector(onFavorite(_:)), for: .touchUpInside)
        return favoriteButton
    }()
    
    private lazy var likeButton: UIButton = {
        let likeButton = Helper.makeButton(
            with: .themeBlue,
            imgForNormalState: .heart,
            imgForSelectedState: .heartFilled,
            width: 35,
            height: 30
        )
        likeButton.addTarget(self, action: #selector(onLike(_:)), for: .touchUpInside)
        return likeButton
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
        self.style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    private func setup() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onAvatarTap))
        friendAvatarView.addGestureRecognizer(gesture)
    }

    private func style() {
        contentView.addSubview(friendAvatarView)
        friendAvatarView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 16)

        friendAvatarView.addSubview(friendAvatarImageView)
        friendAvatarImageView.center(inView: friendAvatarView)

        contentView.addSubview(friendNameLabel)
        friendNameLabel.centerY(inView: self, leftAnchor: friendAvatarView.rightAnchor, paddingLeft: 10)

        contentView.addSubview(onlineIndicator)
        onlineIndicator.centerY(inView: self, rightAnchor: rightAnchor, paddingRight: 32)
    }

    @objc private func onAvatarTap() {
        Helper.animate(view: friendAvatarView)
        delegate?.friendsCollectionViewCellDidReceiveAvatarTap(self)
    }

    @objc private func onFavorite(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        if sender.isSelected {
            let offset = CGPoint(x: -frame.maxX, y: 0)
            sender.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
            sender.isHidden = false
            UIView.animate(
                withDuration: 1,
                delay: 0,
                usingSpringWithDamping: 0.47,
                initialSpringVelocity: 3,
                options: .curveEaseOut,
                animations: {
                    sender.transform = .identity
                    sender.alpha = 1
            })
        }
        
        delegate?.friendsCollectionViewCellDidReceiveFavoriteTap(self)
    }

    @objc private func onLike(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            let offset = CGPoint(x: -frame.maxX, y: 0)
            sender.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
            sender.isHidden = false
            UIView.animate(
                withDuration: 1,
                delay: 0,
                usingSpringWithDamping: 0.47,
                initialSpringVelocity: 3,
                options: .curveEaseOut,
                animations: {
                    sender.transform = .identity
                    sender.alpha = 1
            })
        }
        
        if sender.isSelected {
            likeCounterLabel.text = String(Int(likeCounterLabel.text!)! + 1)
        } else {
            likeCounterLabel.text = String(Int(likeCounterLabel.text!)! - 1)
        }
        
        delegate?.friendsCollectionViewCellDidReceiveLikeTap(self)
    }

    func set(username: String, userAvatarURL: URL, isOnline: Bool) {
        friendAvatarImageView.kf.setImage(with: userAvatarURL)
        friendNameLabel.text = username
        onlineIndicator.isHidden = !isOnline
    }
}
