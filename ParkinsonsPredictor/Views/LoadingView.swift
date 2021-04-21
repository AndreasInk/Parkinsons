//
//  LoadingView.swift
//  ParkinsonsPredictor
//
//  Created by Andreas on 3/4/21.
//

import SwiftUI

struct LoadingView: View {
    @State var animate = false
    @State var animate2 = false
    @State var animate3 = false
    @State var animate4 = false
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("blue"), Color("teal")]), startPoint: .topLeading, endPoint: .bottom)
            .ignoresSafeArea()
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 1.5)) {
                    animate = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.easeInOut(duration: 1.5)) {
                    animate2 = true
                    }
                }
               
            }
            VStack {
                if animate {
            Image(systemName: "heart")
                .font(.system(size: 136))
                .foregroundColor(.white)
                .padding()
                }
                if animate2 {
            Text("Parkinson's Health Tool")
                .font(.custom("Poppins-Bold", size: 32, relativeTo: .headline))
                .foregroundColor(.white)
                .padding()
            
    }
            }
        }
    }
}
