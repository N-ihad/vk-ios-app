//
//  FriendCell.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit

protocol FriendCellDelegate: class {
    func handleLikeTapped(_ cell: FriendCell)
    func handleFavouriteTapped(_ cell: FriendCell)
    func handleFriendAvatarTapped(_ cell: FriendCell)
}

class FriendCell: UITableViewCell {
    // MARK: - Properties
    
    weak var delegate: FriendCellDelegate?
    
    let friendAvatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .vkBlue
        return iv
    }()
    
    let friendAvatarView: UIView = {
        let containerView = UIView()
        containerView.setDimensions(width: 48, height: 48)
        containerView.backgroundColor = .clear
        
        let shadowView = UIView()
        shadowView.setDimensions(width: 48, height: 48)
        shadowView.layer.cornerRadius = 48 / 2
        shadowView.backgroundColor = .vkBlue
        shadowView.dropShadow()
        
        containerView.addSubview(shadowView)
        
        return containerView
    }()
    
    private let friendNameLabel = UILabel()
    
    private let likeCounterLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 20)
        lbl.text = "0"
        return lbl
    }()
    
    private lazy var favouriteButton: UIButton = {
        var img = UIImage(systemName: "star")!
        var imgFilled = UIImage(systemName: "star.fill")!
        let btn = Utilities().button(with: .vkBlue, imgForNormalState: img, imgForSelectedState: imgFilled, width: 35, height: 30)
        btn.addTarget(self, action: #selector(handleFavouriteTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var likeButton: UIButton = {
        var img = UIImage(systemName: "heart")!
        var imgFilled = UIImage(systemName: "heart.fill")!
        let btn = Utilities().button(with: .vkBlue, imgForNormalState: img, imgForSelectedState: imgFilled, width: 35, height: 30)
        btn.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return btn
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
        Utilities().animate(viewToAnimate: friendAvatarView)
        delegate?.handleFriendAvatarTapped(self)
    }
    
    @objc func handleFavouriteTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            let offset = CGPoint(x: -self.frame.maxX, y: 0)
            let x: CGFloat = 0, y: CGFloat = 0
            sender.transform = CGAffineTransform(translationX: offset.x + x, y: offset.y + y)
            sender.isHidden = false
            UIView.animate(
                withDuration: 1, delay: 0, usingSpringWithDamping: 0.47, initialSpringVelocity: 3,
                options: .curveEaseOut, animations: {
                    sender.transform = .identity
                    sender.alpha = 1
            })
        }
        
        delegate?.handleFavouriteTapped(self)
    }
    
    @objc func handleLikeTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            let offset = CGPoint(x: -self.frame.maxX, y: 0)
            let x: CGFloat = 0, y: CGFloat = 0
            sender.transform = CGAffineTransform(translationX: offset.x + x, y: offset.y + y)
            sender.isHidden = false
            UIView.animate(
                withDuration: 1, delay: 0, usingSpringWithDamping: 0.47, initialSpringVelocity: 3,
                options: .curveEaseOut, animations: {
                    sender.transform = .identity
                    sender.alpha = 1
            })
        }
        
        if sender.isSelected {
            likeCounterLabel.text = String(Int(likeCounterLabel.text!)! + 1)
        } else {
            likeCounterLabel.text = String(Int(likeCounterLabel.text!)! - 1)
        }
        
        delegate?.handleLikeTapped(self)
    }
    
    // MARK: - Helpers
    
    func set(username: String, userAvatarURL: URL) {
        friendAvatarImageView.kf.setImage(with: userAvatarURL)
        friendNameLabel.text = username
    }
    
    func configureUI() {
        friendAvatarView.addSubview(friendAvatarImageView)
        self.contentView.addSubview(friendAvatarView)
        self.contentView.addSubview(friendNameLabel)
        self.contentView.addSubview(favouriteButton)
//        self.contentView.addSubview(likeButton)
//        self.contentView.addSubview(likeCounterLabel)
        friendAvatarView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 16)
        friendAvatarImageView.center(inView: friendAvatarView)
        friendNameLabel.centerY(inView: self, leftAnchor: friendAvatarView.rightAnchor, paddingLeft: 10)
//        likeCounterLabel.centerY(inView: self, rightAnchor: rightAnchor, paddingRight: 38)
//        likeButton.centerY(inView: self, rightAnchor: likeCounterLabel.leftAnchor, paddingRight: 8)
        favouriteButton.centerY(inView: self, rightAnchor: rightAnchor, paddingRight: 26)
    }
    
    func configureGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleAvatarTapped))
        self.friendAvatarView.addGestureRecognizer(gesture)
    }
}
