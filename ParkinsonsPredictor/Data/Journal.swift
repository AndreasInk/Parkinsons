//
//  JournalView.swift
//  Curiosity
//
//  Created by Andreas on 3/2/21.
//

import SwiftUI

struct Journal: Identifiable, Codable, Hashable {
    
    var id = UUID()
    var title: String
    var text: String
    

}
