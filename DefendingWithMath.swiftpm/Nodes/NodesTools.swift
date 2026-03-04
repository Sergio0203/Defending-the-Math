//
//  NodesTools.swift
//  DefendingTheMath
//
//  Created by Sérgio César Lira Júnior on 06/02/25.
//
import SpriteKit
import SwiftUI
enum TypesFont: String {
    case regular = "Gaegu-Regular"
    case light = "Gaegu-Light"
    case bold = "Gaegu-Bold"
}

struct NodesTools {
    static let ground: UInt32 = 0x1 << 0
    static let enemy: UInt32 = 0x1 << 1
    static let tower: UInt32 = 0x1 << 2
    static let scale: CGFloat = 0.7

    static func getFont(typeFont: TypesFont) -> Font {
        let urlFont = Bundle.main.url(forResource: typeFont.rawValue, withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(urlFont, CTFontManagerScope.process, nil)
        let font = Font.custom(typeFont.rawValue, size: 80)
        return font
    }
}
