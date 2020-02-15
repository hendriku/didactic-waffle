//
//  EvilProtocol.swift
//  CodableInheritance
//
//  Created by Hendrik Ulbrich on 15.02.20.
//  Copyright © 2020 Hendrik Ulbrich. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init(hexString: String) {
        let scanner = Scanner(string: hexString.replacingOccurrences(of: "#", with: ""))
        scanner.scanLocation = 0

        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xFF0000) >> 16
        let g = (rgbValue & 0xFF00) >> 8
        let b = rgbValue & 0xFF

        self.init(
            red: CGFloat(r) / 0xFF,
            green: CGFloat(g) / 0xFF,
            blue: CGFloat(b) / 0xFF, alpha: 1
        )
    }
    
    public var hex: String {
        let r: CGFloat = cgColor.components?[0] ?? 0.0
        let g: CGFloat = cgColor.components?[1] ?? 0.0
        let b: CGFloat = cgColor.components?[2] ?? 0.0
        return String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
    }
    
}

final public class MyCustomColor: UIColor, Codable {
    private enum CodingKeys: CodingKey {
        case hex
    }
    
    var hexVal: String = "#000"
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.hex, forKey: CodingKeys.hex)
    }
    
    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let hex = try container.decode(String.self, forKey: CodingKeys.hex)
        self.init(hexString: hex)
    }
}

public protocol EvilProtocol {
    var brand01: MyCustomColor? { get }
}

public struct EvilRealisation: EvilProtocol, Codable {
    public var brand01: MyCustomColor? = MyCustomColor(hexString: "#fff")
}
