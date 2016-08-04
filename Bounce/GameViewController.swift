//
//  GameViewController.swift
//  Bounce
//
//  Created by Paul on 07/11/2014.
//  Copyright (c) 2014 Fluid Pixel. All rights reserved.
//

import SceneKit
import QuartzCore
import AppKit

class GameViewController: NSViewController {
    
    @IBOutlet weak var gameView: SCNView!
    
    var cameraNode = SCNNode()
    
    override func awakeFromNib(){

        // set the scene to the view
        self.gameView!.scene = buildScene(&cameraNode)
        
        // allows the user to manipulate the camera
        self.gameView!.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        self.gameView!.showsStatistics = true
        
        // configure the view
        self.gameView!.backgroundColor = blueColor
        
        //self.gameView!.preferredFramesPerSecond = 30
        
    }

}
