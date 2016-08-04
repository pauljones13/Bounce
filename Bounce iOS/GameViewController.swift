//
//  GameViewController.swift
//  Bounce iOS
//
//  Created by Paul on 16/01/2015.
//  Copyright (c) 2015 Fluid Pixel. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    
    var cameraNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene:SCNScene = buildScene(&cameraNode)
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView

        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = blueColor
        
        scnView.preferredFramesPerSecond = 60
        
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return UIInterfaceOrientationMask.AllButUpsideDown
        } else {
            return UIInterfaceOrientationMask.All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
