//
//  PostHeader.swift
//  DSU
//
//  Created by Andreas on 2/17/21.
//

import SwiftUI

struct PostHeader: View {
    @State var name: String
    @State var image: Image
    @State var user: User
    @State var open = false
    @Binding var openFull: Bool
    @State var full = false
    var body: some View {
        HStack {
            if full {
            Button(action: {
                openFull = false
            }) {
                Image(systemName: "xmark")
                    .font(.headline)
                    .padding()
                    .foregroundColor(Color("blue"))
            }
            }
            Button(action: {
                open = true
            }) {
               
            Image("test")
                .resizable()
               
                .scaledToFill()
                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipShape(Circle())
                .padding()
            }
            Spacer()
            Text(name)
                .font(.headline)
                .padding()
                .foregroundColor(Color("blue"))
        } //.padding()
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $open, content: {
            //ProfileView(user: user)
        })
    }
    
}

