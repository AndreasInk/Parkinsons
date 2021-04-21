//
//  PostButtons.swift
//  DSU
//
//  Created by Andreas on 2/17/21.
//

import SwiftUI

struct PostButtons: View {
    var body: some View {
        HStack {
          
            Button(action: {
                
            }) {
                
            
            Image(systemName: "heart")
                .foregroundColor(Color("blue"))
                .padding(5)
                
                .font(.title)
            }.buttonStyle(PlainButtonStyle())
            Button(action: {
                
            }) {
            Image(systemName: "person.2")
                .foregroundColor(Color("blue"))
                .padding(5)
                .font(.title)
            } .buttonStyle(PlainButtonStyle())
            Spacer()
            Button(action: {
                
            }) {
                Image(systemName: "mic")
                    .foregroundColor(Color("teal"))
                    .font(.largeTitle)
                    .font(.title)
            }
            .buttonStyle(PlainButtonStyle())
            .padding()
        }
    }
}

struct PostButtons_Previews: PreviewProvider {
    static var previews: some View {
        PostButtons()
    }
}
