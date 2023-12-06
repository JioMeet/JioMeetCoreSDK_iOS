//
//  GradientView.swift
//  JioMeetUIKit
//
//  Created by Rohit41.Kumar on 21/09/22.
//

import UIKit
class GradientView: UIView {

	override class var layerClass: AnyClass {
		return CAGradientLayer.self
	}
	
	var colors: [UIColor]? {
		didSet { updateLayer() }
	}
	
	func animateColors(newColors: [UIColor]) {
		let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
		gradientChangeAnimation.duration = 0.25
		gradientChangeAnimation.toValue = newColors.compactMap({ $0.cgColor })
		gradientChangeAnimation.fillMode = .forwards
		gradientChangeAnimation.isRemovedOnCompletion = false
		self.layer.add(gradientChangeAnimation, forKey: "colorChange")
	}
	
	private func updateLayer() {
		let layer = self.layer as! CAGradientLayer
		layer.colors = colors?.compactMap({ $0.cgColor })
		layer.startPoint = CGPoint(x: 0.5, y: 0)
		layer.endPoint = CGPoint(x: 0.5, y: 1)
		layer.locations = [0, 1]
		//chatTableContainerFadingLayer.locations = [0, 0.25, 0.99, 1]
	}

}
