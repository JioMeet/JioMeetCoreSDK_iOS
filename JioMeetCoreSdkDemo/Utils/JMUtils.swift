//
//  JMUtils.swift
//  JioMeetUIKit
//
//  Created by Rohit41.Kumar on 21/09/22.
//

import Foundation
import UIKit

func getImage(_ name: String) -> UIImage? {
	let bundle = Bundle.init(for: JMMeetingView.self)
	return UIImage(named: name, in: bundle, compatibleWith: nil)
}
