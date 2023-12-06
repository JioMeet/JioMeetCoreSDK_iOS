//
//  JMMeetingTabBar.swift
//  JioMeetUIKit
//
//  Created by Rohit41.Kumar on 21/09/22.
//

import UIKit
import JioMeetCoreSDK

class JMMeetingTabBar: UIView {

    // MARK: - SubViews
	private var contentStackView = UIStackView()
	private var muteUnmuteMicButton = UIButton()
	private var muteUnMuteMicLabel = UILabel()
	private var muteUnmuteVideoButton = UIButton()
	private var muteUnmuteVideoLabel = UILabel()
	private var switchCameraButton = UIButton()
	private var switchCameraLabel = UILabel()
	private var participantListLabel = UILabel()
	private var leaveCallButton = UIButton()
	private var leaveCallLabel = UILabel()
	
	// MARK: - Internal Properties
	var onPressLeaveCallButton: (() -> Void)?
	
	// MARK: - Super Methods
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	
	// MARK: - Private Functions
	private func commonInit() {
		backgroundColor = UIColor.rgbColor(30, 30, 30)
		configureSubViews()
		arrangeAllSubViews()
		configureSubViewsLayouts()
		
	}
	
	// MARK: - Buttons Actions
	@objc private func didPressMicButton(sender: UIButton) {
        JMMeetingManager.instance.muteUnmuteLocalAudio()
	}
	
	@objc private func didPressVideoButton(sender: UIButton) {
        JMMeetingManager.instance.muteUnmuteLocalVideo()
	}
	
	@objc private func didPressSwitchCameraButton(sender: UIButton) {
        JMMeetingManager.instance.switchCamera()
	}
		
	@objc private func didPressLeaveCallButton(sender: UIButton) {
		onPressLeaveCallButton?()
	}
}

// MARK: - Data Functions
extension JMMeetingTabBar {
	func updateMicButtonState() {
		let localParticipant = JMMeetingManager.instance.getLocalParticipant()
        let isMicMuted = localParticipant?.audioTrack.isMuted ?? false
		let micImage = isMicMuted ? getImage("jm_muted_mic") : getImage("jm_unmuted_mic")
		let micLabel = isMicMuted ? "UnMute" : "Mute"
		muteUnmuteMicButton.setImage(micImage, for: .normal)
		muteUnmuteMicButton.tintColor = isMicMuted ? .systemRed : .white
		
		muteUnMuteMicLabel.text = micLabel
		muteUnMuteMicLabel.textColor = isMicMuted ? .systemRed : .white
	}
	
	func updateVideoButtonState() {
		let localParticipant = JMMeetingManager.instance.getLocalParticipant()
        let isVideoMuted = localParticipant?.videoTrack.isMuted ?? false
		let videoImage = isVideoMuted ? getImage("jm_muted_video") : getImage("jm_unmuted_video")
		let videoLabel = isVideoMuted ? "Start Video" : "Stop Video"
		muteUnmuteVideoButton.setImage(videoImage, for: .normal)
		muteUnmuteVideoButton.tintColor = isVideoMuted ? .systemRed : .white
		
		muteUnmuteVideoLabel.text = videoLabel
		muteUnmuteVideoLabel.textColor = isVideoMuted ? .systemRed : .white
		
		switchCameraButton.isEnabled = isVideoMuted ? false : true
		switchCameraButton.alpha = isVideoMuted ? 0.7 : 1
		switchCameraLabel.alpha = isVideoMuted ? 0.7 : 1
	}
}


// MARK: - Configure SubViews
extension JMMeetingTabBar {
	private func configureSubViews() {
		contentStackView.translatesAutoresizingMaskIntoConstraints = false
		contentStackView.axis = .horizontal
		contentStackView.distribution = .fillEqually
		contentStackView.alignment = .fill
		contentStackView.spacing = 0
		contentStackView.backgroundColor = .clear
				
		[muteUnmuteMicButton, muteUnmuteVideoButton, switchCameraButton, leaveCallButton].forEach({
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.setTitle(nil, for: .normal)
			$0.contentHorizontalAlignment = .fill
			$0.contentVerticalAlignment = .fill
			$0.imageEdgeInsets = UIEdgeInsets(top: 2, left: 7, bottom: 2, right: 7)
			$0.imageView?.contentMode = .scaleAspectFit
			$0.tintColor = .white
		})
		leaveCallButton.imageEdgeInsets = .zero
		
		[muteUnMuteMicLabel, muteUnmuteVideoLabel, switchCameraLabel, participantListLabel, leaveCallLabel].forEach({
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.backgroundColor = .clear
			$0.textAlignment = .center
			$0.font = UIFont.systemFont(ofSize: 10, weight: .medium)
			$0.textColor = .white
			$0.adjustsFontSizeToFitWidth = true
		})
		
		muteUnmuteMicButton.setImage(getImage("jm_unmuted_mic"), for: .normal)
		muteUnMuteMicLabel.text = "Mute"
		muteUnmuteMicButton.addTarget(self, action: #selector(didPressMicButton(sender: )), for: .touchUpInside)
		
		muteUnmuteVideoButton.setImage(getImage("jm_unmuted_video"), for: .normal)
		muteUnmuteVideoLabel.text = "Stop Video"
		muteUnmuteVideoButton.addTarget(self, action: #selector(didPressVideoButton(sender: )), for: .touchUpInside)
		
		switchCameraButton.setImage(getImage("jm_switch_camera"), for: .normal)
		switchCameraLabel.text = "Switch Camera"
		switchCameraButton.addTarget(self, action: #selector(didPressSwitchCameraButton(sender:)), for: .touchUpInside)
				
		leaveCallButton.setImage(getImage("jm_end_call"), for: .normal)
		leaveCallLabel.text = "Leave"
		leaveCallButton.addTarget(self, action: #selector(didPressLeaveCallButton(sender:)), for: .touchUpInside)
	}
	
	private func arrangeAllSubViews() {
		addSubview(contentStackView)
		addTabBarItemToStackView(button: muteUnmuteMicButton, label: muteUnMuteMicLabel)
		addTabBarItemToStackView(button: muteUnmuteVideoButton, label: muteUnmuteVideoLabel)
		addTabBarItemToStackView(button: switchCameraButton, label: switchCameraLabel)
		addTabBarItemToStackView(button: leaveCallButton, label: leaveCallLabel)
		
	}
	
	private func addTabBarItemToStackView(button: UIButton, label: UILabel, badgeLabel: UILabel? = nil) {
		let itemContainerView = UIView()
		itemContainerView.translatesAutoresizingMaskIntoConstraints = false
		itemContainerView.backgroundColor = .clear
		
		itemContainerView.addSubview(button)
		itemContainerView.addSubview(label)
		
		NSLayoutConstraint.activate([
			button.widthAnchor.constraint(equalToConstant: 40),
			button.heightAnchor.constraint(equalToConstant: 30),
			button.topAnchor.constraint(equalTo: itemContainerView.topAnchor),
			button.centerXAnchor.constraint(equalTo: itemContainerView.centerXAnchor),
			
			label.leadingAnchor.constraint(equalTo: itemContainerView.leadingAnchor),
			label.trailingAnchor.constraint(equalTo: itemContainerView.trailingAnchor),
			label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 3),
			label.bottomAnchor.constraint(equalTo: itemContainerView.bottomAnchor)
		])
		
		if let badgeLabel = badgeLabel {
			itemContainerView.insertSubview(badgeLabel, belowSubview: button)
			NSLayoutConstraint.activate([
				badgeLabel.leadingAnchor.constraint(equalTo: itemContainerView.centerXAnchor, constant: 15),
				badgeLabel.bottomAnchor.constraint(equalTo: button.centerYAnchor)
			])
		}
		contentStackView.addArrangedSubview(itemContainerView)
	}
	
	private func configureSubViewsLayouts() {
		
		NSLayoutConstraint.activate([
			contentStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
			contentStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
			contentStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -7.5),
			contentStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 7.5),
		])
	}
}
