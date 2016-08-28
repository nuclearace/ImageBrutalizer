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
    case light
    case noise
    case pixellize
    case stretches(Int)
    case torus(Int)
    case twirls(Int)
    case url(String)
    case vortex(Int)
    case zoomBlur
    
    init(stringArgument: String) {
        let option: String
        let value: Int
        
        if stringArgument.containsString("=") {
            let startOfValue = stringArgument.rangeOfString("=")!.startIndex
            option = stringArgument[stringArgument.startIndex...startOfValue]
            value = Int(stringArgument[startOfValue.advancedBy(1)..<stringArgument.endIndex])!
        } else {
            option = stringArgument
            value = -1
        }
        
        switch option {
        case "-bloom":
            self = .bloom
        case "-bumps=":
            self = .bumps(value)
        case "-holes=":
            self = .holes(value)
        case "-light":
            self = .light
        case "-noise":
            self = .noise
        case "-pixel":
            self = .pixellize
        case "-stretches=":
            self = .stretches(value)
        case "-torus=":
            self = .torus(value)
        case "-twirls=":
            self = .twirls(value)
        case "-vortex=":
            self = .vortex(value)
        case "-zoom":
            self = .zoomBlur
        default:
            self = .url(stringArgument)
        }
    }
    
    func brutalize(with brutalizer: ImageBrutalizer) {
        switch self {
        case .bloom:
            brutalizer.brutalizeWithBloom()
        case let .bumps(numOfBumps):
            brutalizer.brutalizeWithBumps(numberOfBumps: numOfBumps)
        case .light:
            brutalizer.brutalizeWithLightTunnel()
        case let .holes(numOfHoles):
            brutalizer.brutalizeWithHoles(numberOfHoles: numOfHoles)
        case .noise:
            brutalizer.brutalizeWithNoiseReduction()
        case .pixellize:
            brutalizer.brutalizeWithPixelation()
        case let .stretches(numOfStretches):
            brutalizer.brutalizeWithStretching(numberOfStretches: numOfStretches)
        case let .torus(numOfToruses):
            brutalizer.brutalizeWithToruses(numberOfToruses: numOfToruses)
        case let .twirls(numOfTwirls):
            brutalizer.brutalizeWithTwirls(numberOfTwirls: numOfTwirls)
        case let .vortex(numOfVortexes):
            brutalizer.brutalizeWithVortexes(numberOfVortexes: numOfVortexes)
        case .zoomBlur:
            brutalizer.brutalizeWithZoomBlur()
        default:
            break
        }
    }
}
