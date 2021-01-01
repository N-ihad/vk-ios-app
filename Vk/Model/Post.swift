//
//  Post.swift
//  Eigth homework task
//
//  Created by Nihad on 11/17/20.
//

import UIKit

protocol PosterProtocol {
    var avatar: UIImage { get set }
    var name: String { get set }
}

class Post {
    var poster: PosterProtocol
    var description: String
    var image: UIImage
    
    init(poster: PosterProtocol, description: String, image: UIImage) {
        self.poster = poster
        self.description = description
        self.image = image
    }
}
