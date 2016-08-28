//
//  ImageBrutalizer.swift
//  Cropper
//
//  Created by Erik Little on 8/27/16.
//  Copyright © 2016 Erik Little. All rights reserved.
//

import Foundation
import CoreImage
import AppKit

class ImageBrutalizer {
    private let context = CIContext(options: nil)
    private let extent: CGRect
    private let height: Int
    private let width: Int
    
    private var image: CIImage
    
    var outputImage: CGImage {
        return context.createCGImage(image, fromRect: extent)
    }
    
    var outputData: NSData? {
        let outputCGImage = outputImage
        let outputSize = NSSize(width: width, height: height)
        let bitmapRep = NSBitmapImageRep(CGImage: outputCGImage)
        
        bitmapRep.size = outputSize
        
        return bitmapRep.representationUsingType(.NSPNGFileType, properties: [:])
    }
    
    private var randomCenter: CIVector {
        return CIVector(x: CGFloat(arc4random_uniform(UInt32(width))), y: CGFloat(arc4random_uniform(UInt32(height))))
    }
    
    init?(imagePath: String) {
        guard let imageData = NSData(contentsOfFile: imagePath) else { return nil }
        guard let ciImage = CIImage(data: imageData) else { return nil }
        guard let height = ciImage.properties["PixelHeight"] as? Int else { return nil }
        guard let width = ciImage.properties["PixelWidth"] as? Int else { return nil }
        
        self.image = ciImage
        self.extent = image.extent
        self.height = height
        self.width = width
    }
    
    func brutalizeWithBloom() {
        let bloomer = CIFilter(name: "CIBloom", withInputParameters: [
            "inputImage": image,
            "inputRadius": randomNSNumber(200),
            "inputIntensity": randomNSNumber(30)
            ])
        
        image = bloomer?.outputImage ?? image
    }
    
    func brutalizeWithBumps(numberOfBumps bumpNum: Int) {
        for _ in 0..<bumpNum {
            let bumper = CIFilter(name: "CIBumpDistortion", withInputParameters: [
                "inputImage": image,
                "inputCenter": randomCenter,
                "inputRadius": randomNSNumber(500)
                ])
            
            image = bumper?.outputImage ?? image
        }
    }
    
    func brutalizeWithStretching(numberOfStretches numOfStretches: Int) {
        for _ in 0..<numOfStretches {
            let bumper = CIFilter(name: "CIBumpDistortionLinear", withInputParameters: [
                "inputImage": image,
                "inputCenter": randomCenter,
                "inputRadius": randomNSNumber(500),
                "inputAngle": randomNSNumber(360),
                "inputScale": 0.1
                ])
            
            image = bumper?.outputImage ?? image
        }
    }
    
    func brutalizeWithHoles(numberOfHoles holeNum: Int) {
        for _ in 0..<holeNum {
            let holer = CIFilter(name: "CIHoleDistortion", withInputParameters: [
                "inputImage": image,
                "inputCenter": randomCenter,
                "inputRadius": randomNSNumber(30)
                ])
            
            image = holer?.outputImage ?? image
        }
    }
    
    func brutalizeWithNoiseReduction() {
        let reducer = CIFilter(name: "CINoiseReduction", withInputParameters: [
            "inputImage": image,
            "inputNoiseLevel": 0.01,
            "inputSharpness": 20,
            ])
        
        image = reducer?.outputImage ?? image
    }
    
    func brutalizeWithLightTunnel() {
        let tunneler = CIFilter(name: "CILightTunnel", withInputParameters: [
            "inputImage": image,
            "inputCenter": randomCenter,
            "inputRotation": randomNSNumber(40),
            ])
        
        image = tunneler?.outputImage ?? image
    }
    
    func brutalizeWithPixelation() {
        let pixler = CIFilter(name: "CIPixellate", withInputParameters: [
            "inputImage": image,
            "inputCenter": randomCenter,
            "inputScale": randomNSNumber(20)
            ])
        
        image = pixler?.outputImage ?? image
    }
    
    func brutalizeWithToruses(numberOfToruses numOfToruses: Int) {
        for _ in 0..<numOfToruses {
            let toruser = CIFilter(name: "CITorusLensDistortion", withInputParameters: [
                "inputImage": image,
                "inputCenter": randomCenter,
                "inputRadius": randomNSNumber(100),
                "inputWidth": randomNSNumber(50),
                "inputRefraction": randomNSNumber(10)
                ])
            
            image = toruser?.outputImage ?? image
        }
    }
    
    
    func brutalizeWithTwirls(numberOfTwirls numOfTwirls: Int) {
        for _ in 0..<numOfTwirls {
            let twirler = CIFilter(name: "CITwirlDistortion", withInputParameters: [
                "inputImage": image,
                "inputCenter": randomCenter,
                "inputRadius": randomNSNumber(100),
                "inputAngle": randomNSNumber(4)
                ])
            
            image = twirler?.outputImage ?? image
        }
    }
    
    func brutalizeWithVortexes(numberOfVortexes numOfVortexes: Int) {
        for _ in 0..<numOfVortexes {
            let vortexer = CIFilter(name: "CIVortexDistortion", withInputParameters: [
                "inputImage": image,
                "inputCenter": randomCenter,
                "inputRadius": randomNSNumber(200),
                "inputAngle": randomNSNumber(360)
                ])
            
            image = vortexer?.outputImage ?? image
        }
    }
    
    func brutalizeWithZoomBlur() {
        let zoomer = CIFilter(name: "CIZoomBlur", withInputParameters: [
            "inputImage": image,
            "inputCenter": randomCenter,
            "inputAmount": randomNSNumber(50)
            ])
        
        image = zoomer?.outputImage ?? image
        
    }
    
    private func randomNSNumber(limit: Int) -> NSNumber {
        return NSNumber(unsignedInt: arc4random_uniform(UInt32(limit)))
    }
}
