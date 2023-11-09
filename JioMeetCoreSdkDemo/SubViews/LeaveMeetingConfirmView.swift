//
//  LeaveMeetingConfirmView.swift
//  JioMeetUIKit
//
//  Created by Rohit41.Kumar on 21/09/22.
//

import UIKit
import JioMeetCoreSDK

class LeaveMeetingConfirmView: UIView {

	// MARK: - Outlets
	@IBOutlet var contentView: UIView!
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var contentStackView: UIStackView!
	@IBOutlet weak var closeViewButton: UIButton!
	@IBOutlet weak var confirmLeaveButton: UIButton!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	
	private func commonInit() {
		let bundle = Bundle(for: LeaveMeetingConfirmView.self)
		bundle.loadNibNamed("LeaveMeetingConfirmView", owner: self, options: nil)
		addSubview(contentView)
		contentView.frame = bounds
		contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		
		containerView.layer.masksToBounds = true
		containerView.layer.cornerRadius = 20
		
		confirmLeaveButton.layer.borderColor = UIColor.systemRed.cgColor
		confirmLeaveButton.layer.borderWidth = 1.0
		confirmLeaveButton.layer.masksToBounds = true
		confirmLeaveButton.layer.cornerRadius = 20
	}
	
	@IBAction func didPressConfirmLeaveButton(_ sender: UIButton) {
        JMMeetingManager.instance.leaveMeeting()
		removeFromSuperview()
	}
	
	@IBAction func didPressCloseViewButton(_ sender: UIButton) {
		removeFromSuperview()
	}
}
