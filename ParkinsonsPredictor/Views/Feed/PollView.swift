//
//  PollView.swift
//  Curiosity
//
//  Created by Andreas on 3/2/21.
//

import SwiftUI

struct PollView: View {
    @State var poll: Poll
    @State var respoonse = ""
    var body: some View {
        HStack {
        Text(poll.question)
            .bold()
            .multilineTextAlignment(.leading)
            .font(.title)
            .padding()
            Spacer()
        }
        
        if poll.ABC.isEmpty {
            TextEditor(text: $respoonse)
                .padding()
          
        } else {
        ForEach(poll.ABC.indices, id: \.self) { i in
            Button(action: {
                poll.isABC[i].toggle()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .padding()
                        .foregroundColor( poll.isABC[i] ? Color(.systemBlue) : Color(.lightGray))
                        .frame(height: 100)
                    Text(poll.ABC[i])
                        .font(.headline)
                        .foregroundColor(poll.isABC[i] ? Color(.white) : Color(.white))
                }
            }

        }
        } 
    } 
}

