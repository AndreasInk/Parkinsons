//
//  Poll.swift
//  Curiosity
//
//  Created by Andreas on 3/2/21.
//

import SwiftUI

struct Poll: Identifiable, Codable, Hashable {
    
    var id = UUID()
    var name: String
    var question: String
    var ABC: [String]
    var isABC: [Bool]
    var reponsesFrom: [User]
    var responses: [String]
    var memoUrl: String?

}
