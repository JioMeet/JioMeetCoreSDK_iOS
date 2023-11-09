//
//  JMParticipantVideoCell.swift
//  JioMeetUIKit
//
//  Created by Rohit41.Kumar on 21/09/22.
//

import Foundation
import UIKit
import JioMeetCoreSDK

class JMParticipantVideoCell: UICollectionViewCell {
	// MARK: - Subviews
	private var videoView = JMParticipantVideoView()
	// MARK: - Static Properties
	static let identifier = "jm_participant_video_cell"
	
	// MARK: - Super Methods
	override init(frame: CGRect) {
		super.init(frame: frame)
		videoView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(videoView)
		videoView.pinEdgesToSuperView(
			superView: contentView,
			padding: ViewPadding(
				left: 5,
				right: 5,
				top: 5,
				bottom: 5
			)
		)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setParticipant(_ participant: JMMeetingUser) {
		videoView.setParticipant(participant)
	}
}
