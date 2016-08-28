//
//  main.swift
//  Cropper
//
//  Created by Erik Little on 8/27/16.
//  Copyright © 2016 Erik Little. All rights reserved.
//

import Foundation
import CoreImage

let args = Process.arguments[1..<Process.arguments.endIndex].map(BrutalArg.parse)
var imagePath = ""
let imageData: NSData
let ciImage: CIImage
let brutalizer: ImageBrutalizer

for arg in args {
    switch arg {
    case let .url(image):
        imagePath = image
        break
    default:
        continue
    }
}


guard let imageData = NSData(contentsOfFile: imagePath) else { exit(1) }
guard let ciImage = CIImage(data: imageData) else { exit(1) }
guard let brutalizer = ImageBrutalizer(image: ciImage) else { exit(1) }

for arg in args {
    arg.brutalize(brutalizer)
}

guard let outputData = brutalizer.outputData else { exit(1) }

let fileManager = NSFileManager.defaultManager()
let a = ("~/Desktop/brutalized.png" as NSString).stringByExpandingTildeInPath

fileManager.createFileAtPath(a, contents: outputData, attributes: nil)
