//
//  CGRect+Extension.swift
//  JioMeetUIKit
//
//  Created by Rohit41.Kumar on 21/09/22.
//

import Foundation
import UIKit

// MARK: - CGRect Extension
extension CGRect {
	func dividedIntegral(fraction: CGFloat, from fromEdge: CGRectEdge) -> (first: CGRect, second: CGRect) {
		let dimension: CGFloat
		
		switch fromEdge {
		case .minXEdge, .maxXEdge:
			dimension = self.size.width
		case .minYEdge, .maxYEdge:
			dimension = self.size.height
		}
		
		let distance = (dimension * fraction).rounded(.up)
		var slices = self.divided(atDistance: distance, from: fromEdge)
		
		switch fromEdge {
		case .minXEdge, .maxXEdge:
			slices.remainder.origin.x += 0
			slices.remainder.size.width -= 0
		case .minYEdge, .maxYEdge:
			slices.remainder.origin.y += 0
			slices.remainder.size.height -= 0
		}
		
		return (first: slices.slice, second: slices.remainder)
	}
}
