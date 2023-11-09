//
//  JMParticipantVideoView.swift
//  JioMeetUIKit
//
//  Created by Rohit41.Kumar on 21/09/22.
//

import Foundation
import UIKit
import JioMeetCoreSDK

class JMParticipantVideoView: UIView {
	
	// MARK: - Subviews
	private var containerView = UIView()
	private var participantInitialsLabel = UILabel()
	private var videoPlaceHolderView = UIView()
	private var participantInfoStackView = UIStackView()
	private var participantNameLabel = UILabel()
	private var participantMicStatusButton = UIButton()
	private var bottomGradientView = GradientView()
	
	// MARK: - Private Properties
	private var rtcParticipant: JMMeetingUser?
	var localUserID = String()
	// MARK: - Super Methods
	override init(frame: CGRect) {
		super.init(frame: frame)
		layer.masksToBounds = true
		layer.cornerRadius = 7.5
		configureSubViews()
		arrangeAllSubViews()
		configureSubViewsLayouts()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		containerView.layoutIfNeeded()
		
		// Set frames for Participant initials Effect View
		let minLength = min(bounds.width, bounds.height)
		let initialsViewDiameter = minLength * 0.5
		participantInitialsLabel.frame.size = CGSize(width: initialsViewDiameter, height: initialsViewDiameter)
		participantInitialsLabel.center.x = containerView.bounds.width / 2
		participantInitialsLabel.center.y = containerView.bounds.height / 2
		participantInitialsLabel.layer.cornerRadius = initialsViewDiameter / 2
		participantInitialsLabel.font = UIFont.systemFont(ofSize: initialsViewDiameter * 0.4, weight: .medium)
		
	}
	
}

// MARK: - Getters and Setters
extension JMParticipantVideoView {
	func setParticipant(_ participant: JMMeetingUser) {
		rtcParticipant = participant
        videoPlaceHolderView.isHidden = participant.videoTrack.isMuted
		participantNameLabel.text = participant.displayName
		participantInitialsLabel.isHidden = !participant.videoTrack.isMuted
		videoPlaceHolderView.subviews.forEach({ $0.removeFromSuperview() })
        if let participantRtcVideoView = participant.videoTrack.streamView{
			participantRtcVideoView.translatesAutoresizingMaskIntoConstraints = false
			videoPlaceHolderView.addSubview(participantRtcVideoView)
			participantRtcVideoView.pinEdgesToSuperView(superView: videoPlaceHolderView)
		}
		
		participantInitialsLabel.text = participant.displayName.initials.uppercased()
		participantInitialsLabel.backgroundColor = participant.displayName.initialsBackgroundColor
		
		// Hide All subviews other than initial and videoPlaceholder for Local user
		participantNameLabel.isHidden = participant.id == localUserID
		participantInfoStackView.isHidden = participant.id == localUserID
        bottomGradientView.isHidden = participant.id == localUserID ? true : participant.videoTrack.isMuted
		
		// Check wether participant is Pinned or not
		// Set Mic Status
        let micButtonImage = participant.audioTrack.isMuted ? getImage("jm_muted_mic") : getImage("jm_unmuted_mic")
		let micButtonBackground = participant.audioTrack.isMuted ? UIColor.black : UIColor.darkGray
		participantMicStatusButton.setImage(micButtonImage, for: .normal)
		participantMicStatusButton.backgroundColor = micButtonBackground
		participantMicStatusButton.tintColor = participant.audioTrack.isMuted ? .systemRed : .white
	}
	
}

// MARK: - SubViews Configure and Layouts
extension JMParticipantVideoView {
	private func configureSubViews() {
		containerView.translatesAutoresizingMaskIntoConstraints = false
		containerView.backgroundColor = UIColor.rgbColor(30, 30, 30)
		
		participantInitialsLabel.layer.masksToBounds = true
		participantInitialsLabel.textAlignment = .center
		participantInitialsLabel.textColor = .white
		participantInitialsLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
		participantInitialsLabel.backgroundColor = .systemYellow
		participantInitialsLabel.text = "RP"
		
		videoPlaceHolderView.translatesAutoresizingMaskIntoConstraints = false
		videoPlaceHolderView.backgroundColor = .clear
		
		participantInfoStackView.translatesAutoresizingMaskIntoConstraints = false
		participantInfoStackView.axis = .horizontal
		participantInfoStackView.distribution = .fill
		participantInfoStackView.alignment = .fill
		participantInfoStackView.spacing = 0
		participantInfoStackView.backgroundColor = .clear
		participantInfoStackView.layer.cornerRadius = 5
		participantInfoStackView.layer.masksToBounds = true
		
		participantNameLabel.translatesAutoresizingMaskIntoConstraints = false
		participantNameLabel.textColor = .white
		participantNameLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
		participantNameLabel.textAlignment = .left
		participantNameLabel.backgroundColor = .clear
		
		participantMicStatusButton.translatesAutoresizingMaskIntoConstraints = false
		participantMicStatusButton.tintColor = .systemRed
		participantMicStatusButton.imageView?.contentMode = .scaleAspectFit
		participantMicStatusButton.layer.masksToBounds = true
		participantMicStatusButton.backgroundColor = .clear
		participantMicStatusButton.setTitle(nil, for: .normal)
		participantMicStatusButton.isHidden = true
		
		bottomGradientView.translatesAutoresizingMaskIntoConstraints = false
		bottomGradientView.colors = [
			UIColor.black.withAlphaComponent(0),
			UIColor.rgbColor(30, 30, 30).withAlphaComponent(0.75)
		]
	}
	
	private func arrangeAllSubViews() {
		addSubview(containerView)
		containerView.addSubview(participantInitialsLabel)
		containerView.addSubview(videoPlaceHolderView)
		containerView.addSubview(bottomGradientView)
		containerView.addSubview(participantInfoStackView)
		containerView.addSubview(participantMicStatusButton)
		
		participantInfoStackView.addArrangedSubview(participantNameLabel)
	}
	
	private func configureSubViewsLayouts() {
		// Set Content Hugging and Compression Properties of StackView SubViews
		participantMicStatusButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		participantMicStatusButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
		
		participantNameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
		participantNameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		
		// Pin Container view to superView
		containerView.pinEdgesToSuperView(superView: self)
		
		// Pin Video PlaceHolder to ContainerView
		videoPlaceHolderView.pinEdgesToSuperView(superView: containerView)
		
		// Info StackView and Its subview Constraints
		NSLayoutConstraint.activate([
			participantInfoStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 7.5),
			participantInfoStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
		])
		
		NSLayoutConstraint.activate([
			bottomGradientView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			bottomGradientView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
			bottomGradientView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
			bottomGradientView.heightAnchor.constraint(equalToConstant: 60)
		])
		
		NSLayoutConstraint.activate([
			participantMicStatusButton.heightAnchor.constraint(equalToConstant: 25),
			participantMicStatusButton.widthAnchor.constraint(equalToConstant: 25),
			participantMicStatusButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
			participantMicStatusButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10)
		])
		
	}
}
