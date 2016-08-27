//
//  main.swift
//  Cropper
//
//  Created by Erik Little on 8/27/16.
//  Copyright © 2016 Erik Little. All rights reserved.
//

import Foundation
import CoreImage

guard Process.arguments.count == 2 else { exit(1) }

let imagePath = Process.arguments[1]

guard let imageData = NSData(contentsOfFile: imagePath) else { exit(1) }
guard let ciImage = CIImage(data: imageData) else { exit(1) }
guard let brutalizer = ImageBrutalizer(image: ciImage) else { exit(1) }

brutalizer.brutalizeWithBumps(numberOfBumps: 50)
brutalizer.brutalizeWithTwirls(numberOfTwirls: 50)
brutalizer.brutalizeWithHoles(numberOfHoles: 10)

guard let outputData = brutalizer.outputData else { exit(1) }

let fileManager = NSFileManager.defaultManager()
let a = ("~/Desktop/fuckedup.png" as NSString).stringByExpandingTildeInPath

fileManager.createFileAtPath(a, contents: outputData, attributes: nil)
