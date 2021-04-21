//
//  User.swift
//  DSU
//
//  Created by Andreas on 2/17/21.
//

import SwiftUI

struct User: Identifiable, Codable, Hashable {
    
    var id = UUID()
    var name: String
    var date: Date
    var posts: [Post]
    var bio: String?
    var profileImage: Data?

}
