//
//  NSColorExtension.swift
//  Cage
//
//  Created by horimislime on 2015/11/07.
//  Copyright © 2015年 horimislime. All rights reserved.
//

import Cocoa

extension NSColor {
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    struct Cage {
        static let green = NSColor(hex: 0x0A9B94)
    }
}
