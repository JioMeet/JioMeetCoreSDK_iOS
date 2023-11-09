//
//  String+Extension.swift
//  JioMeetUIKit
//
//  Created by Rohit41.Kumar on 21/09/22.
//

import Foundation
import UIKit

extension String {
	
	var initials: String {
		
		let words = components(separatedBy: .whitespacesAndNewlines)
		
		//to identify letters
		let letters = CharacterSet.letters
		var firstChar : String = ""
		var secondChar : String = ""
		var firstCharFoundIndex : Int = -1
		var firstCharFound : Bool = false
		var secondCharFound : Bool = false
		
		for (index, item) in words.enumerated() {
			
			if item.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
				continue
			}
			
			//browse through the rest of the word
			for (_, char) in item.unicodeScalars.enumerated() {
				
				//check if its a aplha
				if letters.contains(char) {
					
					if !firstCharFound {
						firstChar = String(char)
						firstCharFound = true
						firstCharFoundIndex = index
						
					} else if !secondCharFound {
						
						secondChar = String(char)
						if firstCharFoundIndex != index {
							secondCharFound = true
						}
						
						break
					} else {
						break
					}
				}
			}
		}
		
		if firstChar.isEmpty && secondChar.isEmpty {
			firstChar = "D"
			secondChar = "P"
		}
		
		return firstChar + secondChar
	}
	
	var initialsBackgroundColor: UIColor {
		let firstCharacter = (initials.first ?? "U").uppercased()
		switch firstCharacter {
		case "A", "I", "Q", "Y":
			return UIColor.rgbColor(123, 102, 141)
		case "B", "J", "R", "Z":
			return UIColor.rgbColor(102, 129, 141)
		case "C", "K", "S":
			return UIColor.rgbColor(144, 132, 123)
		case "D", "L", "T":
			return UIColor.rgbColor(123, 132, 144)
		case "E", "M", "U":
			return UIColor.rgbColor(102, 114, 141)
		case "F", "N", "V":
			return UIColor.rgbColor(114, 110, 154)
		case "G", "O", "W":
			return UIColor.rgbColor(156, 159, 145)
		case "H", "P", "X":
			return UIColor.rgbColor(128, 128, 141)
		default:
			return UIColor.rgbColor(123, 102, 141)
		}
	}
	
	var textColor: UIColor {
		let firstCharacter = (initials.first ?? "U").uppercased()
		switch firstCharacter {
		case "A", "I", "Q", "Y":
			return UIColor(hexString: "#C135C5")
		case "B", "J", "R", "Z":
			return UIColor(hexString: "#9775E3")
		case "C", "K", "S":
			return UIColor(hexString: "#DDCD8C")
		case "D", "L", "T":
			return UIColor(hexString: "#E3A475")
		case "E", "M", "U":
			return UIColor(hexString: "#5FC0D1")
		case "F", "N", "V":
			return UIColor(hexString: "#5DC69D")
		case "G", "O", "W":
			return UIColor(hexString: "#778CE3")
		case "H", "P", "X":
			return UIColor(hexString: "#F78AAF")
		default:
			return UIColor(hexString: "#C135C5")
		}
	}
    
    var isNumeric: Bool {
        return CharacterSet.decimalDigits.isSuperset(
            of: CharacterSet(
                charactersIn: self
            )
        )
    }
}
