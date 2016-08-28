//
//  Args.swift
//  Cropper
//
//  Created by Erik Little on 8/27/16.
//  Copyright © 2016 Erik Little. All rights reserved.
//

import Foundation

enum BrutalArg {
    case bloom
    case bumps(Int)
    case holes(Int)
    case noise
    case pixellize
    case torus(Int)
    case twirls(Int)
    case url(String)
    case vortex(Int)

    static func parse(string: String) -> BrutalArg {
        let option: String
        let value: Int
        
        if string.containsString("=") {
            let startOfValue = string.rangeOfString("=")!.startIndex
            option = string[string.startIndex...startOfValue]
            value = Int(string[startOfValue.advancedBy(1)..<string.endIndex])!
        } else {
            option = string
            value = -1
        }
        
        switch option {
        case "-bloom":
            return .bloom
        case "-bumps=":
            return .bumps(value)
        case "-holes=":
            return .holes(value)
        case "-pixel":
            return .pixellize
        case "-torus=":
            return .torus(value)
        case "-twirls=":
            return .twirls(value)
        case "-vortex=":
            return .vortex(value)
        default:
            return .url(string)
        }
    }
    
    func brutalize(brutalizer: ImageBrutalizer) {
        switch self {
        case .bloom:
            brutalizer.brutalizeWithBloom()
        case let .bumps(numOfBumps):
            brutalizer.brutalizeWithBumps(numberOfBumps: numOfBumps)
        case let .holes(numOfHoles):
            brutalizer.brutalizeWithHoles(numberOfHoles: numOfHoles)
        case .noise:
            brutalizer.brutalizeWithNoiseReduction()
        case .pixellize:
            brutalizer.brutalizeWithPixelation()
        case let .torus(numOfToruses):
            brutalizer.brutalizeWithToruses(numberOfToruses: numOfToruses)
        case let .twirls(numOfTwirls):
            brutalizer.brutalizeWithTwirls(numberOfTwirls: numOfTwirls)
        case let .vortex(numOfVortexes):
            brutalizer.brutalizeWithVortexes(numberOfVortexes: numOfVortexes)
        default:
            break
        }
    }
}
