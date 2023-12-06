//
//  JMMeetingView+CollectionView.swift
//  JioMeetUIKit
//
//  Created by Rohit41.Kumar on 21/09/22.
//

import Foundation
import UIKit

extension JMMeetingView: UICollectionViewDelegate, UICollectionViewDataSource {
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return remoteParticipants.count
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JMParticipantVideoCell.identifier, for: indexPath) as! JMParticipantVideoCell
		let participant = remoteParticipants[indexPath.item]
		cell.setParticipant(participant)
		return cell
	}

}
