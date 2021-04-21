//
//  PostView.swift
//  DSU
//
//  Created by Andreas on 2/17/21.
//

import SwiftUI

struct PostView: View {
    @State var post: Post
    @State var text = "Text here"
    @State var image = Image("test")
    @State var full = false
    @Binding var open: Bool
    var body: some View {
        ZStack {
            if full {
            
       // GeometryReader { geo in
        VStack {
            
            PostHeader(name: post.createdBy?.name ?? "No name", image: image, user: post.createdBy ?? User(name: "", date: Date(), posts: [Post]()), openFull: $open, full: true)
            HStack {
            Text(post.title)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.leading)
                Spacer()
            } .padding(.horizontal)
            HStack {
            Text(post.text)
                .font(.body)
                .multilineTextAlignment(.leading)
                Spacer()
            }.padding(.horizontal)
            ScrollView {
            if !(post.poll?.isEmpty ?? true) {
                if full {
               
                ForEach(post.poll!, id: \.self) { poll in
                PollView(poll: poll)
                }
                
                } else {
                    
                    Image("test")
                        .resizable()
                        .scaledToFill()
                        
                }
            } else {
                
//                TextEditor(text: $text)
//                    .padding()
//                .font(.body)
//                .multilineTextAlignment(.leading)
//
//                    Button(action: {
//
//                    }) {
//                        Image(systemName: "mic")
//                            .font(.largeTitle)
//                    }
//                    .buttonStyle(PlainButtonStyle())
//                    .padding()
                   
                
                
            }
                Spacer()
               // .frame(width: geo.size.width, height: geo.size.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            PostButtons()
                .padding(.bottom)
           Divider()
                ForEach(post.comments, id: \.self) { comment in
                    VStack {
                    HStack {
                        VStack {
                            
                            Text(comment.text)
                                .font(.headline)
                            
                            Text(comment.user.name)
                                
                                .font(.footnote)
                        }
                        Spacer()
                      
                        
                        Button(action: {
                            
                        }) {
                            Image(systemName: "heart")
                                .foregroundColor(Color("teal"))
                                .font(.largeTitle)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                        
                        Button(action: {
                            
                        }) {
                            Image(systemName: "arrowtriangle.right")
                                .foregroundColor(Color("teal"))
                                .font(.largeTitle)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                    } .padding()
                        Divider()
                    }
                }
            
        }
        }
            } else {
                VStack {
                    PostHeader(name: post.createdBy?.name ?? "No name", image: image, user: post.createdBy ?? User(name: "", date: Date(), posts: [Post]()), openFull: $open)
                   
                    
                    if !(post.poll?.isEmpty ?? true) {
                        if full {
                       
                        ForEach(post.poll!, id: \.self) { poll in
                        PollView(poll: poll)
                        }
                        
                        } else {
                            
                            Image("test")
                                .resizable()
                                .scaledToFill()
                        }
                    } else {
                        
                        Image("test")
                            .resizable()
                            .scaledToFill()
                        
                    }
                       // .frame(width: geo.size.width, height: geo.size.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    PostButtons()
                        .padding(.bottom)
                   
                    HStack {
                    Text(post.title)
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color("blue"))
                        Spacer()
                    } .padding(.horizontal)
                    HStack {
                    Text(post.text)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color("blue"))
                        Spacer()
                    }.padding(.horizontal)
                    
                 
                    Divider()
                    }
                
                
            }
        }
   // }
    }
}

