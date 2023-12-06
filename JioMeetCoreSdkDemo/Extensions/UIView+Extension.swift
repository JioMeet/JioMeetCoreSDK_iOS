//
//  UIView+Extension.swift
//  JioMeetUIKit
//
//  Created by Rohit41.Kumar on 21/09/22.
//

import Foundation
import UIKit

struct ViewPadding {
	var left: CGFloat = 0
	var right: CGFloat = 0
	var top: CGFloat = 0
	var bottom: CGFloat = 0
	
	static let zero = ViewPadding(left: 0, right: 0, top: 0, bottom: 0)
	
}

extension UIView {
	func pinEdgesToSuperView(superView: UIView, padding: ViewPadding = ViewPadding.zero) {
		NSLayoutConstraint.activate([
			leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: padding.left),
			trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -padding.right),
			topAnchor.constraint(equalTo: superView.topAnchor, constant: padding.top),
			bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -padding.bottom)
		])
	}
}
