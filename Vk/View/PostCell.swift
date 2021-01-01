//
//  PostCell.swift
//  Eigth homework task
//
//  Created by Nihad on 11/17/20.
//

import UIKit

protocol PostCellDelegate: class {
    func handleLikeTapped(_ cell: PostCell)
    func handleShareTapped(_ cell: PostCell)
    func handleCommentTapped(_ cell: PostCell)
}

class PostCell: UITableViewCell {
    // MARK: - Properties
    weak var delegate: PostCellDelegate?
    
    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 30 / 2
        iv.backgroundColor = .clear
        return iv
    }()
    
    private let posterNameLabel = UILabel()
    private let postDescription: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30).isActive = true
        return lbl
    }()
    private var postImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .vkBlue
        iv.contentMode = .scaleAspectFit
        iv.setDimensions(width: 300, height: 300)
        return iv
    }()
    private let headerDivider: UIView = {
        return Utilities().divider(color: UIColor.gray)
    }()
    
    private let footerDivider: UIView = {
        return Utilities().divider(color: UIColor.gray)
    }()
    
    private lazy var likeButton: UIButton = {
        var img = UIImage(systemName: "heart")!
        var imgFilled = UIImage(systemName: "heart.fill")!
        let btn = Utilities().button(with: .vkBlue, imgForNormalState: img, imgForSelectedState: imgFilled, width: 35, height: 30)
        btn.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var shareButton: UIButton = {
        var img = UIImage(systemName: "arrowshape.turn.up.left")!
        var imgFilled = UIImage(systemName: "arrowshape.turn.up.left.fill")!
        let btn = Utilities().button(with: .vkBlue, imgForNormalState: img, imgForSelectedState: imgFilled, width: 35, height: 30)
        btn.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return btn
    }()
    
    private let views: UILabel = {
        let lbl = UILabel()
        lbl.sizeToFit()
        lbl.text = "0👀"
        return lbl
    }()
    
    private lazy var commentButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Комментировать", for: .normal)
        btn.setTitleColor(UIColor.vkBlue, for: .normal)
        btn.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleLikeTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.handleLikeTapped(self)
    }
    
    @objc func handleCommentTapped() {
        delegate?.handleCommentTapped(self)
    }
    
    // MARK: - Helpers
    
    func set(post: Post) {
        posterImageView.image = post.poster.avatar
        posterNameLabel.text = post.poster.name
        postDescription.text = post.description
        postImage.image = post.image
    }
    
    func configureUI() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(posterNameLabel)
        contentView.addSubview(headerDivider)
        contentView.addSubview(postDescription)
        contentView.addSubview(postImage)
        contentView.addSubview(footerDivider)
        contentView.addSubview(commentButton)
        posterImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12, width: 48, height: 48)
        posterNameLabel.anchor(top: topAnchor, left: posterImageView.rightAnchor, paddingTop: 12, paddingLeft: 12)
        headerDivider.centerX(inView: self, topAnchor: posterImageView.bottomAnchor, paddingTop: 8)
        postDescription.centerX(inView: self, topAnchor: headerDivider.bottomAnchor, paddingTop: 8)
        postImage.centerX(inView: self, topAnchor: postDescription.bottomAnchor, paddingTop: 8)
        footerDivider.centerX(inView: self, topAnchor: postImage.bottomAnchor, paddingTop: 8)
        
        let stack = UIStackView(arrangedSubviews: [likeButton, shareButton, views])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        contentView.addSubview(stack)
        stack.anchor(top: footerDivider.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 12)
        
        commentButton.anchor(top: footerDivider.bottomAnchor, right: rightAnchor, paddingTop: 8, paddingRight: 12)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
}
