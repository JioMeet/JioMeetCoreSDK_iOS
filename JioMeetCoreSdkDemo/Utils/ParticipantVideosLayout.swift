//
//  ParticipantVideosLayout.swift
//  JioMeetUIKit
//
//  Created by Rohit41.Kumar on 21/09/22.
//

import Foundation
import UIKit

let smallTilesHeightPercent: CGFloat = 0.35

class ParticipantVideosLayout: UICollectionViewFlowLayout {
	
	var contentBounds = CGRect.zero
	var cachedAttributes = [UICollectionViewLayoutAttributes]()
	
	override func prepare() {
		super.prepare()
		sectionInset = .zero
		guard let collectionView = collectionView else { return }
		
		cachedAttributes.removeAll()
		contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)
		
		let itemsCount = collectionView.numberOfItems(inSection: 0)
		var lastFrame: CGRect = .zero
		let cvWidth = collectionView.bounds.size.width
		let cvHeight = collectionView.bounds.size.height
		let segmentFrame = CGRect(x: lastFrame.maxX, y: 0, width: cvWidth, height: cvHeight)
		var segmentRects = [CGRect]()
		
		guard itemsCount > 0 else { return }
        switch itemsCount {
        case 1:
            segmentRects = sliceFrameInOne(segmentFrame: segmentFrame)
        case 2:
            segmentRects = sliceFrameInTwo(segmentFrame: segmentFrame)
        case 3:
            segmentRects = sliceFrameInThree(segmentFrame: segmentFrame)
        default:
            segmentRects = sliceFrameInThree(segmentFrame: segmentFrame)
        }

		var currentIndex = 0
		for rect in segmentRects {
			let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: currentIndex, section: 0))
			attributes.frame = rect
			cachedAttributes.append(attributes)
			contentBounds = contentBounds.union(lastFrame)
			currentIndex += 1
			lastFrame = rect
		}
		contentBounds = contentBounds.union(lastFrame)
	}
	
	private func getFramesForPipMode(itemsCount: Int, collectionViewSize: CGSize) -> [CGRect] {
		var originX: CGFloat = 0
		var allFrames = [CGRect]()
		for _ in 0 ..< itemsCount {
			var frame = CGRect.zero
			frame.size = collectionViewSize
			frame.origin.y = 0
			frame.origin.x = originX
			originX += collectionViewSize.width
			allFrames.append(frame)
		}
		return allFrames
	}
	
	private func sliceFrameInOne(segmentFrame: CGRect) -> [CGRect] {
		var segmentRects = [CGRect]()
		let verticalSlice = segmentFrame.dividedIntegral(fraction: 1.0, from: .minYEdge)
		segmentRects = [verticalSlice.first]
		return segmentRects
	}
	
	private func sliceFrameInTwo(segmentFrame: CGRect) -> [CGRect] {
		var segmentRects = [CGRect]()
		let verticalSlices = segmentFrame.dividedIntegral(fraction: 0.5, from: .minYEdge)
		segmentRects = [verticalSlices.first, verticalSlices.second]
		return segmentRects
	}
	
	private func sliceFrameInThree(segmentFrame: CGRect) -> [CGRect] {
		var segmentRects = [CGRect]()
		let verticalSlices = segmentFrame.dividedIntegral(fraction: 1 - smallTilesHeightPercent, from: .minYEdge)
		let bottomVerticalSlice = verticalSlices.second.dividedIntegral(fraction: 0.5, from: .minXEdge)
		segmentRects = [verticalSlices.first, bottomVerticalSlice.first, bottomVerticalSlice.second]
		return segmentRects
	}
	
	/// - Tag: CollectionViewContentSize
	override var collectionViewContentSize: CGSize {
		return contentBounds.size
	}
	
	/// - Tag: ShouldInvalidateLayout
	override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
		return true
	}
	
	/// - Tag: LayoutAttributesForItem
	override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		guard let itemsCount = collectionView?.numberOfItems(inSection: 0) else { return nil }
		guard itemsCount > 0 else { return nil }
		if itemsCount > 3 {
			let xOffset = collectionView?.contentOffset.x ?? .zero
			cachedAttributes.first?.frame.origin = CGPoint(x: xOffset, y: 0)
			cachedAttributes.first?.zIndex = 1
		}
		return cachedAttributes[indexPath.item]
	}
	
	/// - Tag: LayoutAttributesForElements
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		var attributesArray = [UICollectionViewLayoutAttributes]()
		guard let itemsCount = collectionView?.numberOfItems(inSection: 0) else { return attributesArray }
		guard itemsCount > 0 else { return attributesArray }
		if itemsCount > 3 {
			let xOffset = collectionView?.contentOffset.x ?? .zero
			cachedAttributes.first?.frame.origin = CGPoint(x: xOffset, y: 0)
			cachedAttributes.first?.zIndex = 1
			attributesArray.append(cachedAttributes[0])
		}
		
		for (index, item) in cachedAttributes.enumerated() {
			if index != 0 {
				if rect.contains(CGPoint(x: item.frame.minX, y: item.frame.minY)) || rect.contains(CGPoint(x: item.frame.maxX, y: item.frame.minY)) {
					attributesArray.append(item)
				}
			} else {
				if itemsCount < 4 {
					attributesArray.insert(item, at: 0)
				}
			}
		}
		return attributesArray
	}
	
	// Perform a binary search on the cached attributes array.
	func binSearch(_ rect: CGRect, start: Int, end: Int) -> Int? {
		if end < start { return nil }
		
		let mid = (start + end) / 2
		let attr = cachedAttributes[mid]
		
		if attr.frame.intersects(rect) {
			return mid
		} else {
			if attr.frame.maxY < rect.minY {
				return binSearch(rect, start: (mid + 1), end: end)
			} else {
				return binSearch(rect, start: start, end: (mid - 1))
			}
		}
	}
	
	var realVisibleCellsIndex: [Int] {
		guard let collection = collectionView else { return [] }
		let real = CGRect(origin: collection.contentOffset, size: collection.frame.size)
		return cachedAttributes.filter({ real.contains($0.center) }).map { $0.indexPath.item }
	}
	
	var realVisibleCells: [UICollectionViewCell] {
		guard let collection = collectionView else { return [] }
		let real = CGRect(origin: collection.contentOffset, size: collection.frame.size)
		return cachedAttributes.filter({ real.contains($0.center) }).compactMap({ collection.cellForItem(at: $0.indexPath)})
	}
}

