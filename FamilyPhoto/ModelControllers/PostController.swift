//
//  PostController.swift
//  FamilyPhoto
//
//  Created by Colin Smith on 6/17/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit

class PostController {
    
    static let shared = PostController()
    
    var posts: [Post] = []
    
    func addComment(text: String, post: Post, completion: @escaping (Comment) -> Void){
        
    }
    
    func createPostWith(caption: String, image: UIImage, completion: @escaping (Post?) -> Void){
        let newPost = Post(photoData: nil, caption: caption, photo: image)
        self.posts.append(newPost)
    }
    
    
}
