//
//  UIColor+Extension.swift
//  JioMeetUIKit
//
//  Created by Rohit41.Kumar on 21/09/22.
//

import Foundation
import UIKit

extension UIColor {
	static func rgbColor(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) -> UIColor {
		return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
	}
	
	static var random: UIColor {
		let redValue = CGFloat.random(in: 0...1)
		let greenValue = CGFloat.random(in: 0...1)
		let blueValue = CGFloat.random(in: 0...1)
		return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1)
	}
	
	convenience init(hexString: String, alpha: CGFloat = 1.0) {
		let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		let scanner = Scanner(string: hexString)
		if (hexString.hasPrefix("#")) {
			scanner.scanLocation = 1
		}
		var color: UInt32 = 0
		scanner.scanHexInt32(&color)
		let mask = 0x000000FF
		let r = Int(color >> 16) & mask
		let g = Int(color >> 8) & mask
		let b = Int(color) & mask
		let red   = CGFloat(r) / 255.0
		let green = CGFloat(g) / 255.0
		let blue  = CGFloat(b) / 255.0
		self.init(red:red, green:green, blue:blue, alpha:alpha)
	}
}
