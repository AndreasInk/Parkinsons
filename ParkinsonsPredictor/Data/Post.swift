//
//  Post.swift
//  DSU
//
//  Created by Andreas on 2/17/21.
//

import SwiftUI


struct Post: Identifiable, Codable, Hashable {
    
    var id = UUID()
    var title: String
    var createdBy: User?
    var text: String
    var date: Date
    var likes: Double
    var likedBy: [User]
    var comments: [Comment]
    var image: Data?
    var poll: [Poll]?
}
