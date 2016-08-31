//
//  ImageBrutalizer.swift
//  Cropper
//
//  Created by Erik Little on 8/27/16.
//  Copyright © 2016 Erik Little. All rights reserved.
//

import AppKit

class ImageBrutalizer {
    fileprivate let context = CIContext(options: nil)
    fileprivate let extent: CGRect
    fileprivate let height: Int
    fileprivate let width: Int
    
    fileprivate var image: CIImage
    
    var outputImage: CGImage {
        return context.createCGImage(image, from: extent)!
    }
    
    var outputData: Data? {
        let outputCGImage = outputImage
        let outputSize = NSSize(width: width, height: height)
        let bitmapRep = NSBitmapImageRep(cgImage: outputCGImage)
        
        bitmapRep.size = outputSize
        
        return bitmapRep.representation(using: .PNG, properties: [:])
    }
    
    fileprivate var randomCenter: CIVector {
        return CIVector(x: CGFloat(arc4random_uniform(UInt32(width))), y: CGFloat(arc4random_uniform(UInt32(height))))
    }
    
    init?(imagePath: String) {
        guard let imageData = try? Data(contentsOf: URL(fileURLWithPath: imagePath)) else { return nil }
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
                "inputRadius": randomNSNumber(width > 2000 ? 700 : 500),
                "inputScale": width > 2000 ? 0.9 : 0.5
                ])
            
            image = bumper?.outputImage ?? image
        }
    }
    
    func brutalizeWithStretching(numberOfStretches numOfStretches: Int) {
        for _ in 0..<numOfStretches {
            let stretcher = CIFilter(name: "CIBumpDistortionLinear", withInputParameters: [
                "inputImage": image,
                "inputCenter": randomCenter,
                "inputRadius": randomNSNumber(500),
                "inputAngle": randomNSNumber(360),
                "inputScale": 0.1
                ])
            
            image = stretcher?.outputImage ?? image
        }
    }
    
    func brutalizeWithHoles(numberOfHoles holeNum: Int) {
        for _ in 0..<holeNum {
            let holer = CIFilter(name: "CIHoleDistortion", withInputParameters: [
                "inputImage": image,
                "inputCenter": randomCenter,
                "inputRadius": randomNSNumber(width > 2000 ? 80 : 30)
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
                "inputRadius": randomNSNumber(width > 2000 ? 300 : 100),
                "inputWidth": randomNSNumber(width > 2000 ? 150 : 50),
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
                "inputRadius": randomNSNumber(width > 2000 ? 400 : 100),
                "inputAngle": randomNSNumber(6)
                ])
            
            image = twirler?.outputImage ?? image
        }
    }
    
    func brutalizeWithVortexes(numberOfVortexes numOfVortexes: Int) {
        for _ in 0..<numOfVortexes {
            let vortexer = CIFilter(name: "CIVortexDistortion", withInputParameters: [
                "inputImage": image,
                "inputCenter": randomCenter,
                "inputRadius": randomNSNumber(width > 2000 ? 1000 : 200),
                "inputAngle": randomNSNumber(360)
                ])
            
            image = vortexer?.outputImage ?? image
        }
    }
    
    func brutalizeWithZoomBlur() {
        let zoomer = CIFilter(name: "CIZoomBlur", withInputParameters: [
            "inputImage": image,
            "inputCenter": randomCenter,
            "inputAmount": randomNSNumber(5)
            ])
        
        image = zoomer?.outputImage ?? image
        
    }
    
    fileprivate func randomNSNumber(_ limit: Int) -> NSNumber {
        return NSNumber(value: arc4random_uniform(UInt32(limit)))
    }
}
