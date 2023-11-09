//
//  JMMeetingView.swift
//  JioMeetUIKit
//
//  Created by Rohit41.Kumar on 21/09/22.
//

import UIKit
import JioMeetCoreSDK

public class JMMeetingView: UIView {
	
	// MARK: - SubViews
	internal let joiningMeetingInfoStackView = UIStackView()
	internal let joiningMeetingLoader: UIActivityIndicatorView = {
		if #available(iOS 13.0, *) {
			let loader = UIActivityIndicatorView(style: .large)
			loader.color = .white
			return loader
		} else {
			return UIActivityIndicatorView(style: .whiteLarge)
		}
	}()
	internal let joiningMeetingLabel = UILabel()
	internal let localVideoView = UIView()
	internal let tabBarView = JMMeetingTabBar()
	internal var videosCollectionView: UICollectionView!
	
	// MARK: - Constraints
	var localVideoViewWidthConstraint: NSLayoutConstraint!
	var localVideoViewHeightConstraint: NSLayoutConstraint!
	var localVideoViewTopConstraint: NSLayoutConstraint!
	var localVideoViewTrailingConstraint: NSLayoutConstraint!
	var localVideoViewBottomConstraint: NSLayoutConstraint!
	var localVideoViewLeadingConstraint: NSLayoutConstraint!
	var collectionViewPipBottomConstraint: NSLayoutConstraint!
	var collectionViewNormalBottomConstraint: NSLayoutConstraint!
	
	// MARK: - Internal Properties
	internal let identifier = UUID()
	internal var videosLayout = ParticipantVideosLayout()
	internal var remoteParticipants = [JMMeetingUser]()
    internal var delegate: JMMeetingViewDelegate?

	// MARK: - Super Methods
	public override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	
	// MARK: - Private Methods
	private func commonInit() {
		backgroundColor = UIColor.rgbColor(20, 20, 20)
		configureSubViews()
		arrangeAllSubViews()
		configureSubViewsLayouts()
		
		// Initial state of SubViews
		localVideoView.isHidden = true
		tabBarView.isHidden = true
		
		handleSubViewClosures()
        JMMeetingManager.instance.addSubscriber(subscriber: self, identifier: identifier)
	}
	
	private func handleSubViewClosures() {
		tabBarView.onPressLeaveCallButton = {[weak self] in
			guard let strongSelf = self else { return }
			let confirmLeaveView = LeaveMeetingConfirmView()
			confirmLeaveView.translatesAutoresizingMaskIntoConstraints = false
			strongSelf.addSubview(confirmLeaveView)
			confirmLeaveView.pinEdgesToSuperView(superView: strongSelf)
		}
    }
}

// MARK: - Data Functions
extension JMMeetingView {
	public func setLocalVideoViewSize(size: CGSize) {
		localVideoViewWidthConstraint.constant = size.width
		localVideoViewHeightConstraint.constant = size.height
		layoutIfNeeded()
	}
    
    public func setEnviorment(enviroment: String) {
        JMMeetingManager.instance.setEnviorment(environment: enviroment)
    }
	
    public func joinMeeting(meetingData: JMJoinMeetingData, config: JMJoinMeetingConfig, delegate: JMMeetingViewDelegate?) {
        self.delegate = delegate
        JMMeetingManager.instance.joinMeeting(meetingData: meetingData, config: config)
    }
		
	public func getLocalParticipant() -> JMMeetingUser? {
		return JMMeetingManager.instance.getLocalParticipant()
	}
	
	public func getRemoteParticipants() -> [JMMeetingUser]{
		return JMMeetingManager.instance.getRemoteParticipants()
	}
	
}

// MARK: - ConfigureSubViews
extension JMMeetingView {
	private func configureSubViews() {
		joiningMeetingInfoStackView.translatesAutoresizingMaskIntoConstraints = false
		joiningMeetingInfoStackView.axis = .vertical
		joiningMeetingInfoStackView.distribution = .fill
		joiningMeetingInfoStackView.alignment = .center
		joiningMeetingInfoStackView.spacing = 10
		joiningMeetingInfoStackView.backgroundColor = .clear
		
		joiningMeetingLoader.translatesAutoresizingMaskIntoConstraints = false
		joiningMeetingLoader.startAnimating()
		
		joiningMeetingLabel.translatesAutoresizingMaskIntoConstraints = false
		joiningMeetingLabel.textColor = .white
		joiningMeetingLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
		joiningMeetingLabel.textAlignment = .center
		joiningMeetingLabel.numberOfLines = 0
		joiningMeetingLabel.text = "Joining the meeting..."
		
		
		localVideoView.translatesAutoresizingMaskIntoConstraints = false
		localVideoView.backgroundColor = UIColor.rgbColor(55, 55, 55)
		localVideoView.layer.cornerRadius = 10
		localVideoView.layer.masksToBounds = true
		localVideoView.layer.borderColor = UIColor.lightGray.cgColor
		localVideoView.layer.borderWidth = 0.5
		
		videosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: videosLayout)
		videosCollectionView.translatesAutoresizingMaskIntoConstraints = false
		videosCollectionView.backgroundColor = .clear
		videosCollectionView.delegate = self
		videosCollectionView.dataSource = self
		videosCollectionView.showsHorizontalScrollIndicator = false
		videosCollectionView.showsVerticalScrollIndicator = false
		videosCollectionView.contentInset = .zero
		videosCollectionView.contentInsetAdjustmentBehavior = .never
		videosCollectionView.register(JMParticipantVideoCell.self, forCellWithReuseIdentifier: JMParticipantVideoCell.identifier)
		
		tabBarView.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func arrangeAllSubViews() {
		addSubview(videosCollectionView)
		addSubview(joiningMeetingInfoStackView)
		addSubview(localVideoView)
		addSubview(tabBarView)
		
		joiningMeetingInfoStackView.addArrangedSubview(joiningMeetingLoader)
		joiningMeetingInfoStackView.addArrangedSubview(joiningMeetingLabel)
	}
	
	private func configureSubViewsLayouts() {
		localVideoViewWidthConstraint = localVideoView.widthAnchor.constraint(equalToConstant: 125)
		localVideoViewHeightConstraint = localVideoView.heightAnchor.constraint(equalToConstant: 135)
		localVideoViewTopConstraint = localVideoView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15)
		localVideoViewTrailingConstraint = localVideoView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15)
		localVideoViewBottomConstraint = localVideoView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
		localVideoViewLeadingConstraint = localVideoView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
		
		collectionViewPipBottomConstraint = videosCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
		collectionViewNormalBottomConstraint = videosCollectionView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor)
		
		NSLayoutConstraint.activate([
			joiningMeetingInfoStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
			joiningMeetingInfoStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
			joiningMeetingInfoStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
			
			localVideoViewWidthConstraint,
			localVideoViewHeightConstraint,
			localVideoViewTopConstraint,
			localVideoViewTrailingConstraint,
			
			tabBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
			tabBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
			tabBarView.bottomAnchor.constraint(equalTo: bottomAnchor),
			
			videosCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			videosCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			videosCollectionView.topAnchor.constraint(equalTo: topAnchor),
			collectionViewNormalBottomConstraint
		])
	}
}
