//
//  JMMeetingViewDelegate.swift
//  JioMeetUIKit
//
//  Created by Rohit41.Kumar on 09/06/23.
//

import Foundation

public protocol JMMeetingViewDelegate {
	func didLocalParticipantLeaveMeeting()
	func didLocalUserFailedToJoinMeeting(errorMessage: String)
}
