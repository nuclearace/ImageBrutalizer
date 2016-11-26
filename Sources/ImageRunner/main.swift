//
//  main.swift
//  Cropper
//
//  Created by Erik Little on 8/27/16.
//  Copyright © 2016 Erik Little. All rights reserved.
//

#if os(macOS)

import Foundation
import ImageBrutalizer

let args = CommandLine.arguments.dropFirst().map(BrutalArg.init)
var imagePath = ""

loop: for arg in args {
    switch arg {
    case let .url(image):
        imagePath = image
        break loop
    default:
        continue
    }
}

guard let brutalizer = ImageBrutalizer(imagePath: imagePath) else { exit(1) }

for arg in args {
    arg.brutalize(with: brutalizer)
}

guard let outputData = brutalizer.outputData else { exit(1) }

let fileManager = FileManager.default
let a = ("~/Desktop/brutalized.png" as NSString).expandingTildeInPath

fileManager.createFile(atPath: a, contents: outputData, attributes: nil)

#endif
