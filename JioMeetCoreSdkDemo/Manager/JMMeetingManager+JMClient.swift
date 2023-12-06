//
//  JMMeetingManager+JMClient.swift
//  JioMeetUIKit
//
//  Created by Rohit41.Kumar on 22/05/23.
//

import Foundation
import UIKit
import JioMeetCoreSDK

extension JMMeetingManager: JMClientDelegate {
    
    func jmClient(didLocalUserFailedToJoinMeeting error: JMMeetingJoinError) {
        meetingUpdatesSubscribers.values.forEach({
            $0?.didLocalUserFailedToJoinMeeting(error: error)
        })
    }
    
    func jmClient(_ meeting: JMMeeting, didLocalUserJoinedMeeting user: JMMeetingUser) {
        updatePropertiesWithMeetingObject(meeting: meeting)
        allMediaTracks = [user]
        localMeetingUser = user
        meetingUpdatesSubscribers.values.forEach({
            $0?.didLocalUserJoinedMeetingSuccessfully(manager: self)
        })
    }
    
    func jmClient(_ meeting: JMMeeting, didLocalUserMicStatusUpdated isMuted: Bool) {
        updatePropertiesWithMeetingObject(meeting: meeting)
        meetingUpdatesSubscribers.values.forEach({
            $0?.didLocalUserDataUpdated(manager: self, user: localMeetingUser, updateType: .mic)
        })
    }
    
    func jmClient(_ meeting: JMMeeting, didLocalUserVideoStatusUpdated isMuted: Bool) {
        updatePropertiesWithMeetingObject(meeting: meeting)
        meetingUpdatesSubscribers.values.forEach({
            $0?.didLocalUserDataUpdated(manager: self, user: localMeetingUser, updateType: .video)
        })
    }
    
    func jmClient(_ meeting: JMMeeting, didLocalUserHandRaiseStatusUpdated isRaised: Bool) {
        updatePropertiesWithMeetingObject(meeting: meeting)
        meetingUpdatesSubscribers.values.forEach({
            $0?.didLocalUserDataUpdated(manager: self, user: localMeetingUser, updateType: .handRaise)
        })
    }
    
    func jmClient(_ meeting: JMMeeting, didRemoteUserJoinedMeeting user: JMMeetingUser) {
        jioMeetClient?.subscribeRemoteUserAudio(id: user.id)
        
        jioMeetClient?.subscribeRemoteUserVideo(id: user.id)
        
        updatePropertiesWithMeetingObject(meeting: meeting)
        meetingUpdatesSubscribers.values.forEach({
            $0?.didRemoteUsersCountUpdated(manager: self, user: user, updateType: .join)
        })
        
        // Filter On Videos
        let videoOnUsers = allMediaTracks
            .filter({ $0.sourceType == .user })
            .filter({ $0.videoTrack.isMuted == false })
        
        if videoOnUsers.count > 2 {
            videoOnUsers.forEach({
                jioMeetClient?.setVideoStreamQuality(quality: .low, uid: $0.id)
            })
        } else {
            videoOnUsers.forEach{(
                jioMeetClient?.setVideoStreamQuality(quality: .high, uid: $0.id)
            )}
        }
    }
    
    func jmClient(_ meeting: JMMeeting, didRemoteUserMicStatusUpdated user: JMMeetingUser, isMuted: Bool) {
        updatePropertiesWithMeetingObject(meeting: meeting)
        meetingUpdatesSubscribers.values.forEach({
            $0?.didRemoteUserDataUpdated(manager: self, user: user, updateType: .mic)
        })
    }
    
    func jmClient(_ meeting: JMMeeting, didRemoteUserVideoStatusUpdated user: JMMeetingUser, isMuted: Bool) {
        updatePropertiesWithMeetingObject(meeting: meeting)
        meetingUpdatesSubscribers.values.forEach({
            $0?.didRemoteUserDataUpdated(manager: self, user: user, updateType: .video)
        })
        
        // Filter On Videos
        let videoOnUsers = allMediaTracks
            .filter({ $0.sourceType == .user })
            .filter({ $0.videoTrack.isMuted == false })
        
        if videoOnUsers.count > 2 {
            videoOnUsers.forEach({
                jioMeetClient?.setVideoStreamQuality(quality: .low, uid: $0.id)
            })
        } else {
            videoOnUsers.forEach{(
                jioMeetClient?.setVideoStreamQuality(quality: .high, uid: $0.id)
            )}
        }
    }
    
    func jmClient(_ meeting: JMMeeting, didRemoteUserHandRaiseStatusUpdated user: JMMeetingUser, isRaised: Bool) {
        updatePropertiesWithMeetingObject(meeting: meeting)
        meetingUpdatesSubscribers.values.forEach({
            $0?.didRemoteUserDataUpdated(manager: self, user: user, updateType: .handRaise)
        })
    }
    
    func jmClient(_ meeting: JMMeeting, didRemoteUserLeftMeeting user: JMMeetingUser, reason: JMUserLeftReason) {
        updatePropertiesWithMeetingObject(meeting: meeting)
        allMediaTracks.removeAll(where: { $0.id == user.id })
        meetingUpdatesSubscribers.values.forEach({
            $0?.didRemoteUsersCountUpdated(manager: self, user: user, updateType: .left)
        })
    }
    
    
    func jmClient(_ meeting: JMMeeting, didMeetingDataRefreshed reason: JMMeetingDataRefreshReason) {
        updatePropertiesWithMeetingObject(meeting: meeting)
        meetingUpdatesSubscribers.values.forEach({
            $0?.didMeetingDataRefreshed(manager: self)
        })
    }
    
    
    
    func jmClient(_ meeting: JMMeeting, didLocalUserLeftMeeting reason: JMUserLeftReason) {
        self.allMediaTracks.removeAll()
        self.localMeetingUser = JMMeetingUser()
        meetingUpdatesSubscribers.values.forEach({
            $0?.didLocalUserLeftMeeting(manager: self, reason: reason)
        })
    }
    
}

// MARK: - JMClient Delegate Helper
extension JMMeetingManager {
	func updatePropertiesWithMeetingObject(meeting: JMMeeting) {
		self.allMediaTracks = meeting.allMediaTracks
		self.localMeetingUser = meeting.localParticipant
	}
}
