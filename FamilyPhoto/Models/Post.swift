//
//  Post.swift
//  FamilyPhoto
//
//  Created by Colin Smith on 6/17/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit

class Post {
    var photoData: Data?
    let timestamp: Date
    let caption: String
    let comments: [Comment]
    var photo: UIImage? {
        get{
            guard let data = photoData else {return UIImage()}
            return UIImage(data: data)
        }
        set{
            photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
    init(photoData: Data?, timestamp: Date = Date(), caption: String, comments: [Comment] = [], photo: UIImage?){
        self.caption = caption
        self.timestamp = timestamp
        self.photoData = photoData
        self.comments = comments
        self.photo = photo
    }
}


class Comment {
    let text: String
    let timestamp: Date
    weak var post: Post?
    
    init(text: String, timestamp: Date, post: Post){
        self.text = text
        self.timestamp = timestamp
        self.post = post
        
    }
}

