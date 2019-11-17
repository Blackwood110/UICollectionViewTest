//
//  PhotoCollectionViewLayout.swift
//  UICollectionViewTest
//
//  Created by Александр Дергилёв on 17.11.2019.
//  Copyright © 2019 Александр Дергилёв. All rights reserved.
//

import UIKit

protocol PhotoCollectionViewLayoutDelegate: class {
    func ratio(forItemAt indexPath: IndexPath) -> CGFloat
}

class PhotoCollectionViewLayout: UICollectionViewLayout {
    weak var delegate: PhotoCollectionViewLayoutDelegate?
    private var cache: [IndexPath: UICollectionViewLayoutAttributes] = [:]
//    private let cellWidth: CGFloat = 200
    
    override var collectionViewContentSize: CGSize {
        var maxX: CGFloat = 0
        var maxY: CGFloat = 0
        for attribute in self.cache.values {
            if maxX < attribute.frame.maxX {
                maxX = attribute.frame.maxX
            }
            if maxY < attribute.frame.maxY {
                maxY = attribute.frame.maxY
            }
        }
        return CGSize(width: maxX, height: maxY)
    }
    
    override func prepare() {
        super.prepare()
        self.cache = [:]
        guard let collectionView = self.collectionView, let delegate = self.delegate else {
            return
        }
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let cellWidth = collectionView.frame.width / 2
        
        var firstColumnHeight: CGFloat = 0
        var secondColumnHeight: CGFloat = 0
        var allAttributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]
        for itemIndex in 0..<numberOfItems {
            let indexPath = IndexPath(row: itemIndex, section: 0)
            let ratio = delegate.ratio(forItemAt: indexPath)
            let cellHeight = cellWidth / ratio
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let isForFirstColumn = firstColumnHeight <= secondColumnHeight
            let x = isForFirstColumn ? 0.0 : cellWidth
            let y = isForFirstColumn ? firstColumnHeight : secondColumnHeight
            attributes.frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
            allAttributes[indexPath] = attributes
            
            if isForFirstColumn {
                firstColumnHeight += cellHeight
            } else {
                secondColumnHeight += cellHeight
            }
        }
        self.cache = allAttributes
//        let numberOfItems = collectionView.numberOfItems(inSection: 0)
//        let width: CGFloat = 200
//        let height: CGFloat = 200
//        var allAttributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]
//        for itemNumber in 0..<numberOfItems {
//            let indexPath = IndexPath(row: itemNumber, section: 0)
//            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//            attributes.frame = CGRect(x: CGFloat(itemNumber) * width, y: 0, width: width, height: height)
//            allAttributes[indexPath] = attributes
//        }
//        self.cache = allAttributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.cache.values.filter { $0.frame.intersects(rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cache[indexPath]
    }
//    // snapping (доскроливание)
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//        let x = proposedContentOffset.x
//        let nearestIndex = Int((x + self.cellWidth / 2) / self.cellWidth)
//        let resultX = CGFloat(nearestIndex) * self.cellWidth
//        return CGPoint(x: resultX, y: proposedContentOffset.y)
//    }
}
