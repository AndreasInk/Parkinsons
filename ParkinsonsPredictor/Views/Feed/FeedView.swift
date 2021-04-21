//
//  FeedView.swift
//  DSU
//
//  Created by Andreas on 2/17/21.
//

import SwiftUI

struct FeedView: View {
    @State var posts = [Post(title: "Title", createdBy: User(name: "Andreas", date: Date(), posts: [Post]()), text: "text", date: Date(), likes: 2.0, likedBy: [User](), comments: [Comment(text: "Hello", user: User(name: "Person", date: Date(), posts: [Post]()), date: Date(), likedBy: [User](), replies: [Comment]())]), Post(title: "Title", createdBy: User(name: "Andreas", date: Date(), posts: [Post]()), text: "text", date: Date(), likes: 2.0, likedBy: [User](), comments: [Comment]())]
    @State var user = User(name: "Andreas", date: Date(), posts: [Post]())
    @State var show = false
    var body: some View {
        
        
        VStack {
            ScrollView {
              
                    ForEach(posts, id: \.self) { post in
                        PostView(post: post, open: $show)
                            .onTapGesture(count: 2, perform: {
                                show = true
                            })
                            .sheet(isPresented: $show, content: {
                                PostView(post: post, full: true, open: $show)
                                  
                            })
                    }
                
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
