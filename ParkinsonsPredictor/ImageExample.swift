//
//  ImageExample.swift
//  ParkinsonsPredictor
//
//  Created by Andreas on 3/9/21.
//

import SwiftUI

struct ImageExample: View {
    @State var imageData = Data()
    var body: some View {
        Color.white
            .onAppear() {
                let defaults = UserDefaults.standard
                // comment out after first run and make sure an image in the assets folder is named test
                //defaults.set(UIImage(named: "test")?.pngData(), forKey: "image")
                let imageData = defaults.data(forKey: "image")
                //uncomment after first run
                self.imageData = imageData!
            }
        Image(uiImage: UIImage(data: imageData) ?? UIImage(named: "test")!)
    }
}

struct ImageExample_Previews: PreviewProvider {
    static var previews: some View {
        ImageExample()
    }
}
