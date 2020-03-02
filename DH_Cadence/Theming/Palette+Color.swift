//
//  Palette+Color.swift
//  Financial App
//
//  Created by Craig Clayton on 11/20/19.
//  Copyright © 2019 Cocoa Academy. All rights reserved.
//

import SwiftUI
import Foundation

extension Color {
    static let baseOrientBlue = Color("OrientBlue")
    static let baseRegalBlue = Color("RegalBlue")
    static let basePrussianBlue = Color("PrussianBlue")
    static let baseRockBlue = Color("RockBlue")
    static let baseEndeavourBlue = Color("EndeavourBlue")
    static let baseDustyGray = Color("DustyGray")
    static let baseGreen = Color("JungleGreen")
    static let baseLightGreen = Color("JungleLightGreen")
    static let baseHokiBlue = Color("HokiBlue")
    static let baseWhite = Color("AquaHaze")
    static let baseLightWhite = Color("White")
    static let baseLightGray = Color("LightGray")
    static let baseMediumGray = Color("MediumGray")
    static let baseRed = Color("Red")
    static let baseRedLight = Color("RedLight")
}

extension UIColor {
    static let baseOrientBlue = Color(named: "OrientBlue")
    static let baseRegalBlue = Color(named: "RegalBlue")
    static let baseDustyGray = Color(named: "DustyGray")
    static let basePrussianBlue = Color(named: "PrussianBlue")
    static let baseRockBlue = Color(named: "RockBlue")
    static let baseEndeavourBlue = Color(named: "EndeavourBlue")
    static let baseGreen = Color(named: "JungleGreen")
    static let baseLightGreen = Color(named: "JungleLightGreen")
    static let baseHokiBlue = Color(named: "HokiBlue")
    static let baseWhite = Color(named: "AquaHaze")
    static let baseLightWhite = Color(named: "White")
    static let baseMediumGray = Color(named: "MediumGray")
    static let baseLightGray = Color(named: "LightGray")
    static let baseRed = Color(named: "Red")
    static let baseRedLight = Color(named: "RedLight")


    private static func Color(named key: String) -> UIColor {
       if let color = UIColor(named: key, in: .main, compatibleWith: nil) {
           return color
       }

       return .black
    }
}

