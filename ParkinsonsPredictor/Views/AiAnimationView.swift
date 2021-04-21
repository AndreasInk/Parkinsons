//
//  AiAnimationView.swift
//  ParkinsonsPredictor
//
//  Created by Andreas on 4/9/21.
//

import SwiftUI
import SceneKit
struct AiAnimationView: View {
    var scene = SCNScene()
    
    var cameraNode: SCNNode? {
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        box.firstMaterial?.diffuse.contents = UIColor.red
        let node = SCNNode(geometry: box)
        node.position = SCNVector3(0,0,0)
        //node.rotation = SCNVector4(0,0,0,0)
        return node
    }
    
    var body: some View {
        ZStack {
            Color.white
                .onAppear() {
                    for i in 0...9 {
                        let box = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0)
                        box.firstMaterial?.diffuse.contents = UIColor.red
                        let node = SCNNode(geometry: box)
                        
                        node.position = SCNVector3(0,0,i)
                        scene.rootNode.addChildNode(node)
                        
                        let node2 = SCNNode(geometry: box)
                        
                        node2.position = SCNVector3(i,0,0)
                        scene.rootNode.addChildNode(node2)
                        
                        let node3 = SCNNode(geometry: box)
                        
                        node3.position = SCNVector3(i,0,i)
                        scene.rootNode.addChildNode(node3)
                    }
                    
                }
            SceneView(
                    scene: scene,
                    pointOfView: cameraNode,
                    options: []
            )
        }
    }
}

struct AiAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AiAnimationView()
    }
}
