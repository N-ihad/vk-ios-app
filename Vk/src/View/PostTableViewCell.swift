//
//  PostCell.swift
//  Eigth homework task
//
//  Created by Nihad on 11/17/20.
//

import UIKit

protocol PostTableViewCellDelegate: AnyObject {
    func postTableViewCellDidReceiveLikeTap(_ cell: PostTableViewCell)
    func postTableViewCellDidReceiveShareTap(_ cell: PostTableViewCell)
    func postTableViewCellDidReceiveCommentTap(_ cell: PostTableViewCell)
}

final class PostTableViewCell: UITableViewCell {

    weak var delegate: PostTableViewCellDelegate?

    private let posterImageView: UIImageView = {
        let posterImageView = UIImageView()
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.clipsToBounds = true
        posterImageView.setDimensions(width: 48, height: 48)
        posterImageView.layer.cornerRadius = 30 / 2
        posterImageView.backgroundColor = .clear
        return posterImageView
    }()

    private let posterNameLabel = UILabel()

    private let postDescription: UILabel = {
        let postDescription = UILabel()
        postDescription.numberOfLines = 0
        postDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        let width = UIScreen.main.bounds.width - 30
        postDescription.widthAnchor.constraint(equalToConstant: width).isActive = true
        return postDescription
    }()

    private var postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.backgroundColor = .themeBlue
        postImage.contentMode = .scaleAspectFit
        postImage.setDimensions(width: 300, height: 300)
        return postImage
    }()

    private let headerDivider = Utilities.makeDividerView(color: UIColor.gray)
    private let footerDivider = Utilities.makeDividerView(color: UIColor.gray)
    
    private lazy var likeButton: UIButton = {
        let likeButton = Utilities.makeButton(
            with: .themeBlue,
            imgForNormalState: .heart,
            imgForSelectedState: .heartFilled,
            width: 35,
            height: 30
        )
        likeButton.addTarget(self, action: #selector(onLike(_:)), for: .touchUpInside)
        return likeButton
    }()
    
    private lazy var shareButton: UIButton = {
        let shareButton = Utilities.makeButton(
            with: .themeBlue,
            imgForNormalState: .share,
            imgForSelectedState: .shareFilled,
            width: 35,
            height: 30
        )
        return shareButton
    }()

    private let numberOfViewsLabel: UILabel = {
        let numberOfViewsLabel = UILabel()
        numberOfViewsLabel.text = "0👀"
        numberOfViewsLabel.sizeToFit()
        return numberOfViewsLabel
    }()

    private lazy var commentButton: UIButton = {
        let commentButton = UIButton()
        commentButton.setTitle("Комментировать", for: .normal)
        commentButton.setTitleColor(.themeBlue, for: .normal)
        commentButton.addTarget(self, action: #selector(onOpenComments), for: .touchUpInside)
        return commentButton
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    private func layout() {
        contentView.addSubview(posterImageView)
        posterImageView.anchor(
            top: topAnchor,
            left: leftAnchor,
            paddingTop: 12,
            paddingLeft: 12,
            width: 48,
            height: 48
        )

        contentView.addSubview(posterNameLabel)
        posterNameLabel.anchor(top: topAnchor, left: posterImageView.rightAnchor, paddingTop: 12, paddingLeft: 12)

        contentView.addSubview(headerDivider)
        headerDivider.centerX(inView: self, topAnchor: posterImageView.bottomAnchor, paddingTop: 8)

        contentView.addSubview(postDescription)
        postDescription.centerX(inView: self, topAnchor: headerDivider.bottomAnchor, paddingTop: 8)

        contentView.addSubview(postImage)
        postImage.centerX(inView: self, topAnchor: postDescription.bottomAnchor, paddingTop: 8)

        contentView.addSubview(footerDivider)
        footerDivider.centerX(inView: self, topAnchor: postImage.bottomAnchor, paddingTop: 8)
        
        let stack = UIStackView(arrangedSubviews: [likeButton, shareButton, numberOfViewsLabel])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        contentView.addSubview(stack)
        stack.anchor(top: footerDivider.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 12)

        contentView.addSubview(commentButton)
        commentButton.anchor(
            top: footerDivider.bottomAnchor,
            right: rightAnchor,
            paddingTop: 8,
            paddingRight: 12
        )
    }

    @objc private func onLike(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.postTableViewCellDidReceiveLikeTap(self)
    }

    @objc private func onOpenComments() {
        delegate?.postTableViewCellDidReceiveCommentTap(self)
    }

    func set(post: Post) {
        posterImageView.image = post.poster.avatar
        posterNameLabel.text = post.poster.name
        postDescription.text = post.description
        postImage.image = post.image
    }
}
