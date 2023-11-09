//
//  JMMeetingManager.swift
//  JioMeetUIKit
//
//  Created by Rohit41.Kumar on 15/05/23.
//

import Foundation
import UIKit
import JioMeetCoreSDK


class JMMeetingManager: NSObject {

    static var instance = JMMeetingManager()
    var jioMeetClient: JMClient?
    var meetingUpdatesSubscribers = [UUID: JMMeetingUpdates?]()
    var localMeetingUser = JMMeetingUser()
    var allMediaTracks = [JMMediaTrack]()
    var joinParams = [String: Any]()

    // MARK: - Meeting Methods
    
    // MARK: - Manager Method
    func addSubscriber(subscriber: JMMeetingUpdates?, identifier: UUID) {
        meetingUpdatesSubscribers.updateValue(subscriber, forKey: identifier)
    }
    
    func removeSubscriber(identifier: UUID) {
        meetingUpdatesSubscribers.removeValue(forKey: identifier)
    }
    
    public func setEnviorment(environment: String) {
        joinParams[JMClientConstants.serverEnvironment.rawValue] = environment
    }
    
    func joinMeeting(meetingData: JMJoinMeetingData, config: JMJoinMeetingConfig) {
        UIApplication.shared.isIdleTimerDisabled = true
        
        self.jioMeetClient = JMClient()
        
        var isUserJoiningAsAudience = false
        
        if config.userRole == .audience {
            isUserJoiningAsAudience = true
        }
        
        let joinMeetingConfig = JMJoinMeetingConfig(
            userRole: config.userRole,
            isInitialAudioOn: isUserJoiningAsAudience ? false : config.isInitialAudioOn,
            isInitialVideoOn: isUserJoiningAsAudience ? false : config.isInitialVideoOn
        )
        
        self.jioMeetClient?.setParameters(params: joinParams)
        self.jioMeetClient?.joinMeeting(
            data: meetingData,
            config: joinMeetingConfig,
            delegate: self
        )
    }
    
    func getLocalParticipant() -> JMMeetingUser? {
        return self.jioMeetClient?.getMeetingLocalUser()
    }
    
    func getRemoteParticipants() -> [JMMeetingUser] {
        return self.jioMeetClient?.getMeetingRemoteUsers() ?? []
    }
    
    func leaveMeeting() {
        self.jioMeetClient?.leaveMeeting(reason: .leaveMeeting)
    }
    
    func muteUnmuteLocalAudio() {
        let currentMuteState = localMeetingUser.audioTrack.isMuted
        jioMeetClient?.muteLocalAudio(isMute: !currentMuteState)
    }
    
    func muteUnmuteLocalVideo() {
        let currentMuteState = localMeetingUser.videoTrack.isMuted
        jioMeetClient?.muteLocalVideo(isMute: !currentMuteState)
    }

    func switchCamera() {
        jioMeetClient?.switchCamera()
    }
}
