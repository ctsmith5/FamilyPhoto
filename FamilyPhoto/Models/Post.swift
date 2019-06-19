//
//  Post.swift
//  FamilyPhoto
//
//  Created by Colin Smith on 6/17/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit
import CloudKit

//MARK: - Post Class

class Post {
    
    
    var photoData: Data?
    var recordID: CKRecord.ID
    var timestamp: Date
    var caption: String
    var comments: [Comment]
    var commentCount: Int
    
    var photo: UIImage? {
        get {
            guard let photoData = photoData else {return nil}
            return UIImage(data: photoData)
        }
        set{
            photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
    var imageAsset: CKAsset? {
        get {
            let tempDirectory = NSTemporaryDirectory()
            let tempDirecotryURL = URL(fileURLWithPath: tempDirectory)
            let fileURL = tempDirecotryURL.appendingPathComponent(recordID.recordName).appendingPathExtension("jpg")
            do {
                try photoData?.write(to: fileURL)
            }
            catch let error { print("Error writing to temp url \(error) \(error.localizedDescription)")
            }
            return CKAsset(fileURL: fileURL)
        }
    }
    
    init(timestamp: Date = Date(), caption: String, comments: [Comment] = [], recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), photo: UIImage, commentCount: Int = 0){
        self.timestamp = timestamp
        self.caption = caption
        self.comments = comments
        self.commentCount = commentCount
        self.recordID = recordID
        self.photo = photo
    }
    
    init?(ckRecord: CKRecord){
        do{
            guard let caption = ckRecord[PostConstants.captionKey] as? String,
                let timestamp = ckRecord[PostConstants.timestampKey] as? Date,
                let photoAsset = ckRecord[PostConstants.photoKey] as? CKAsset,
                let commentsCount = ckRecord[PostConstants.countKey] as? Int else {return nil}
            
            guard let urlPath = photoAsset.fileURL else {return}
            let photoData = try Data(contentsOf: urlPath)
            
            self.photoData = photoData
            self.caption = caption
            self.timestamp = timestamp
            self.commentCount = commentsCount
            self.comments = []
            self.recordID = ckRecord.recordID
        }catch{
            print("Nothing is ok")
            return nil
        }
    }
}
//MARK: - Extensions
extension CKRecord {
    convenience init?(post: Post) {
        self.init(recordType: PostConstants.typeKey, recordID: post.recordID)
        self.setValue(post.caption, forKey: PostConstants.captionKey)
        self.setValue(post.timestamp, forKey: PostConstants.timestampKey)
        self.setValue(post.imageAsset, forKey: PostConstants.photoKey)
    }
}

struct PostConstants {
    static let typeKey = "Post"
    static let captionKey = "caption"
    static let timestampKey = "timestamp"
    static let commentsKey = "comments"
    static let countKey = "commentCount"
    static let photoKey = "photo"
}

extension Post: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        if self.caption.contains(searchTerm) {
            return true
        }else{
            for comment in comments {
                if comment.matches(searchTerm: searchTerm) {
                    return true
                }
            }
        }
        return false
    }
    
}

//MARK: - Comment Class
class Comment: SearchableRecord {
    
    func matches(searchTerm: String) -> Bool {
        if self.text.contains(searchTerm){
            return true
        }else{
            return false
        }
    }
    
    let text: String
    let timestamp: Date
    var recordId: CKRecord.ID
    weak var post: Post?
    
    init(text: String, timestamp: Date, post: Post, recordId: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)){
        self.text = text
        self.timestamp = timestamp
        self.post = post
        self.recordId = recordId
    }
}
