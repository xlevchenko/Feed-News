//
//  DetailPost.swift
//  Feed News
//
//  Created by Olexsii Levchenko on 7/12/22.
//

import Foundation

//MARK: - DetailPost
struct DetailPost: Codable {
    let post: PostResult
}

// MARK: - Post
struct PostResult: Codable {
    let postID: Int
    let timeshamp: Date
    var title, text: String
    let postImage: String
    let likesCount: Int

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title, text, postImage
        case likesCount = "likes_count"
    }
}
