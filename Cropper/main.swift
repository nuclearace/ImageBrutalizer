//
//  main.swift
//  Cropper
//
//  Created by Erik Little on 8/27/16.
//  Copyright © 2016 Erik Little. All rights reserved.
//

import Foundation

let args = Process.arguments[1..<Process.arguments.endIndex].map(BrutalArg.init)
var imagePath = ""

for arg in args {
    switch arg {
    case let .url(image):
        imagePath = image
        break
    default:
        continue
    }
}

guard let brutalizer = ImageBrutalizer(imagePath: imagePath) else { exit(1) }

for arg in args {
    arg.brutalize(with: brutalizer)
}

guard let outputData = brutalizer.outputData else { exit(1) }

let fileManager = NSFileManager.defaultManager()
let a = ("~/Desktop/brutalized.png" as NSString).stringByExpandingTildeInPath

fileManager.createFileAtPath(a, contents: outputData, attributes: nil)
