//
//  JMMeetingUpdates.swift
//  JioMeetUIKit
//
//  Created by Rohit41.Kumar on 15/05/23.
//

import Foundation
import JioMeetCoreSDK

enum JMUserDataUpdateType {
	case mic
	case video
	case handRaise
    case coHost
}

enum JMUserCountUpdateType {
	case join
	case left
}

protocol JMMeetingUpdates {
    func didLocalUserFailedToJoinMeeting(error: JMMeetingJoinError)
	func didLocalUserJoinedMeetingSuccessfully(manager: JMMeetingManager)
	
	func didLocalUserDataUpdated(manager: JMMeetingManager, user: JMMeetingUser, updateType: JMUserDataUpdateType)
	
	func didRemoteUsersCountUpdated(manager: JMMeetingManager, user: JMMeetingUser, updateType: JMUserCountUpdateType)
	func didRemoteUserDataUpdated(manager: JMMeetingManager, user: JMMeetingUser, updateType: JMUserDataUpdateType)
	
	func didLocalUserLeftMeeting(manager: JMMeetingManager, reason: JMUserLeftReason)
    func didMeetingDataRefreshed(manager: JMMeetingManager)

}

extension JMMeetingUpdates {
    func didLocalUserFailedToJoinMeeting(error: JMMeetingJoinError) { }
    func didLocalUserJoinedMeetingSuccessfully(manager: JMMeetingManager) { }
    func didLocalUserDataUpdated(manager: JMMeetingManager, user: JMMeetingUser, updateType: JMUserDataUpdateType) { }
    func didRemoteUsersCountUpdated(manager: JMMeetingManager, user: JMMeetingUser, updateType: JMUserCountUpdateType) { }
    func didRemoteUserDataUpdated(manager: JMMeetingManager, user: JMMeetingUser, updateType: JMUserDataUpdateType) { }
    func didLocalUserLeftMeeting(manager: JMMeetingManager, reason: JMUserLeftReason) { }
    func didMeetingDataRefreshed(manager: JMMeetingManager) { }
}
