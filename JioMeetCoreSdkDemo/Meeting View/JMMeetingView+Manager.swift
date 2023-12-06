//
//  JMMeetingView+Manager.swift
//  JioMeetUIKit
//
//  Created by Rohit41.Kumar on 21/09/22.
//

import Foundation
import UIKit
import JioMeetCoreSDK

extension JMMeetingView {
	
	internal func reloadLocalVideoView() {
		// guard let localParticipant = JMManager.instance.getLocalParticipant() else { return }
		localVideoView.subviews.forEach({ $0.removeFromSuperview() })
		let participantVideoView = JMParticipantVideoView()
		participantVideoView.translatesAutoresizingMaskIntoConstraints = false
		localVideoView.addSubview(participantVideoView)
		participantVideoView.pinEdgesToSuperView(superView: localVideoView)
		guard let localParticipant = JMMeetingManager.instance.getLocalParticipant() else { return }
		participantVideoView.setParticipant(localParticipant)
        localVideoView.isHidden = localParticipant.videoTrack.isMuted
	}
	
	private func reloadCollectionView() {
		remoteParticipants = JMMeetingManager.instance.getRemoteParticipants()
		videosCollectionView.reloadData()
	}
}
extension JMMeetingView: JMMeetingUpdates {
    
    func didLocalUserFailedToJoinMeeting(error: JMMeetingJoinError) {
        var errorMessageString = ""
        switch error {
        case .invalidConfiguration:
            errorMessageString = "Failed to Get Configurations"
        case .invalidMeetingDetails:
            errorMessageString = "Invalid Meeting ID or PIN, Please check again."
        case .meetingExpired:
            errorMessageString = "This meeting has been expired."
        case .meetingLocked:
            errorMessageString = "Sorry, you cannot join this meeting because room is locked."
        case .failedToRegisterUser:
            errorMessageString = "Failed to Register User for Meeting."
        case .maxParticipantsLimit:
            errorMessageString = "Maximum Participant Limit has been reached for this meeting."
        case .failedToJoinCall(let errorMessage):
            errorMessageString = errorMessage
        case .other(let errorMessage):
            errorMessageString = errorMessage
        default:
            errorMessageString = "Unknown Error Occurred."
        }
        delegate?.didLocalUserFailedToJoinMeeting(errorMessage: errorMessageString)
    }
    
    func didLocalUserJoinedMeetingSuccessfully(manager: JMMeetingManager) {
        joiningMeetingLoader.isHidden = true
        joiningMeetingLabel.isHidden = true
        joiningMeetingInfoStackView.layoutIfNeeded()
        
        tabBarView.isHidden = false
        tabBarView.updateMicButtonState()
        tabBarView.updateVideoButtonState()
        
        localVideoView.isHidden = false
        reloadLocalVideoView()
    }
    
    func didLocalUserDataUpdated(manager: JMMeetingManager, user: JMMeetingUser, updateType: JMUserDataUpdateType) {
        reloadLocalVideoView()
        switch updateType {
        case .mic:
            tabBarView.updateMicButtonState()
        case .video:
            tabBarView.updateVideoButtonState()
        default:
            break
        }
    }
    
    func didRemoteUsersCountUpdated(manager: JMMeetingManager, user: JMMeetingUser, updateType: JMUserCountUpdateType) {
        reloadCollectionView()
        if remoteParticipants.count == 0 {
            joiningMeetingInfoStackView.isHidden = false
        } else {
            joiningMeetingInfoStackView.isHidden = true
        }
    }
    
    func didRemoteUserDataUpdated(manager: JMMeetingManager, user: JMMeetingUser, updateType: JMUserDataUpdateType) {
        reloadCollectionView()
    }
    
    func didMeetingDataRefreshed(manager: JMMeetingManager) {
        reloadCollectionView()
    }
    
    func didLocalUserLeftMeeting(manager: JMMeetingManager, reason: JMUserLeftReason) {
        manager.removeSubscriber(identifier: identifier)
        reloadCollectionView()
        reloadLocalVideoView()
        self.delegate?.didLocalParticipantLeaveMeeting()
    }
}

