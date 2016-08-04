//
//  CommonGameController.swift
//  Bounce
//
//  Created by Paul on 19/01/2015.
//  Copyright (c) 2015 Fluid Pixel. All rights reserved.
//

import Foundation

import SceneKit

func buildScene(inout cameraNode:SCNNode) -> SCNScene {

    let scene = SCNScene()
    
    scene.background.contents = (0..<6).map { "Sea\($0).jpg" }
    //scene.background.contents = (0..<6).map { "FluidPixel\($0).jpg" }
    //scene.background.contents = (0..<6).map { "Earth\($0).jpg" }
        
    cameraNode.camera = SCNCamera()
    scene.rootNode.addChildNode(cameraNode)
    cameraNode.position = SCNVector3(x: 0, y: 5, z: 25)
    
    // create and add a light to the scene
    let lightNode = SCNNode()
    lightNode.light = SCNLight()
    lightNode.light!.type = SCNLightTypeOmni
    lightNode.light!.color = whiteColor
    lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
    scene.rootNode.addChildNode(lightNode)
    
    let ambientLightNode = SCNNode()
    ambientLightNode.light = SCNLight()
    ambientLightNode.light!.type = SCNLightTypeAmbient
    ambientLightNode.light!.color = darkGrayColor
    scene.rootNode.addChildNode(ambientLightNode)
    
    var counter = 0
    let colourList = [greenColor, blueColor, redColor, yellowColor, orangeColor]
    
    let shinies = colourList.map {
        (colour:SCNColour) -> [SCNMaterial] in
        let m = SCNMaterial()
        m.diffuse.contents = colour
        m.diffuse.intensity = 0.3
        m.reflective.contents = scene.background.contents
        return [m]
    }
    
    for xi in -5...5 {
        let x = SCNFloat(xi)
        for zi in -5...5 {
            let z = SCNFloat(zi)
            
                
                let ball = SCNNode()
                ball.geometry = SCNSphere(radius: 1.5)
                
                counter += 1
                ball.geometry?.materials = shinies[counter % colourList.count]
                
                ball.physicsBody = SCNPhysicsBody.dynamicBody()
                ball.physicsBody?.physicsShape = SCNPhysicsShape(geometry: SCNSphere(radius: 1.5), options: nil)
                ball.physicsBody?.velocity = SCNVector3(x: 0.01, y: x + z, z: 0.01);
                ball.physicsBody?.angularVelocity = SCNVector4(x: 0.3, y: 0.4, z: 0.5, w: 20.0)
                ball.physicsBody?.restitution = 1.2 // 1.0
                ball.physicsBody?.damping = 0.0
                
                //ball.physicsBody?.rollingFriction = 0.0
                
                ball.physicsBody?.charge = (counter % 2 == 0) ? 10000 :  -10000
                
                ball.position = SCNVector3(x: x + z, y: x + 10.0, z: z);
            
            
            scene.rootNode.addChildNode(ball)
            
        }
    }

    
    // create a plane
    
    
    scene.rootNode.addChildNode({
        
        let ff = SCNFloor()
        
        let floor = SCNNode()
        floor.geometry = ff
        floor.geometry?.firstMaterial?.diffuse.contents = grayColor
        floor.geometry?.firstMaterial?.reflective.contents = scene.background.contents
        floor.physicsBody = SCNPhysicsBody.staticBody()
        //floor.physicsBody?.physicsShape = SCNPhysicsShape(geometry: SCNPlane(), options: nil)
        
        return floor
        
    }())
    
    scene.rootNode.addChildNode({
        
        let jar = SCNNode()
        jar.geometry = nil;
        jar.physicsBody = SCNPhysicsBody.staticBody()
        jar.position = SCNVector3(x: 0.0, y: 0.0, z: 0.0)
        jar.geometry = SCNCylinder(radius: 15.0, height: 100.0)
        //jar.geometry = SCNSphere(radius: 24.0)
        jar.geometry?.firstMaterial?.diffuse.contents = lightGray
        jar.opacity = 0.5
        
        jar.physicsBody?.physicsShape = SCNPhysicsShape(geometry: jar.geometry!,
            options: [SCNPhysicsShapeTypeKey:SCNPhysicsShapeTypeConcavePolyhedron])
        
        return jar
        
    }())
    
    return scene
    
}
