//
//  Comment.swift
//  DSU
//
//  Created by Andreas on 2/17/21.
//

import SwiftUI


struct Comment: Identifiable, Codable, Hashable {
    
    var id = UUID()
    var text: String
    var mesageURL: URL?
    var user: User
    var date: Date
    var likedBy: [User]
    var replies: [Comment]

}
