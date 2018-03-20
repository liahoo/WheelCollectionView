//
//  CircularCollectionViewCell.swift
//  CircularCollectionView
//
//  Created by Liang Hu on 18/03/18.
//  Copyright (c) 2018 Liang Hu. All rights reserved.
//

import UIKit

class CircularCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
  
  // Default anchor is at center of Cell
  var anchorPoint = CGPoint(x: 0.5, y: 0.5)
  
  var angle: CGFloat = 0 {
    didSet {
      zIndex = Int(angle*1000000)
      transform = CGAffineTransform(rotationAngle: angle)
    }
  }
  
  override func copy(with zone: NSZone? = nil) -> Any {
    let copiedAttributes: CircularCollectionViewLayoutAttributes =
      super.copy(with: zone) as! CircularCollectionViewLayoutAttributes
    copiedAttributes.anchorPoint = self.anchorPoint
    copiedAttributes.angle = self.angle
    return copiedAttributes
  }
  
}

class CircularCollectionViewLayout: UICollectionViewLayout {
  enum Quarter {
    case Left
    case Right
//    case Top
//    case Bottom
  }
  
  var quarter = Quarter.Left
  let itemSize = CGSize(width: 120, height: 120)
  var radius: CGFloat = 300 {
    didSet {
      invalidateLayout()
    }
  }
  override var collectionViewContentSize: CGSize {
    return CGSize(width: collectionView!.bounds.width,
                  height: CGFloat(collectionView!.numberOfItems(inSection: 0))*itemSize.height)
  }

  var anglePerItem: CGFloat {
    return atan(itemSize.height/radius)
  }

  var angleAtExtreme: CGFloat {
    return collectionView!.numberOfItems(inSection: 0) > 0
      ? -CGFloat(collectionView!.numberOfItems(inSection: 0)-1)*anglePerItem
      : 0
  }
  

  var angle: CGFloat {
    return angleAtExtreme*collectionView!.contentOffset.y/(collectionViewContentSize.height - collectionView!.bounds.height)
  }

  var attributesList = [CircularCollectionViewLayoutAttributes]()
  func createAttr(index: Int) -> CircularCollectionViewLayoutAttributes {
    let attributes = CircularCollectionViewLayoutAttributes(forCellWith: IndexPath(item: index, section: 0))
    attributes.size = self.itemSize
    switch quarter {
    case Quarter.Left:
      attributes.angle = self.angle + self.anglePerItem*CGFloat(index)
      attributes.center =
        CGPoint(x: collectionView!.bounds.width - itemSize.width/2,
                y: collectionView!.bounds.midY)
      attributes.anchorPoint =
        CGPoint(x: (itemSize.width/2.0 - radius)/itemSize.width,
                y: 0.5)
      break
    case Quarter.Right:
      attributes.angle = -self.angle - self.anglePerItem*CGFloat(index)
     attributes.center =
        CGPoint(x: collectionView!.bounds.width - (collectionView!.bounds.width - itemSize.width/2),
                y: collectionView!.bounds.midY)
      attributes.anchorPoint =
        CGPoint(x: (itemSize.width/2.0 + radius)/itemSize.width,
                y: 0.5)
      break
    }
    attributes.size = self.itemSize
    return attributes
  }
  override func prepare() {
    super.prepare()
    //1
    let theta = atan2(collectionView!.bounds.height/2.0,
                      radius + (itemSize.width/2.0) - collectionView!.bounds.width/2)
    //2
    var startIndex = 0
    var endIndex = collectionView!.numberOfItems(inSection: 0) - 1
    //3
    if (angle < -theta) {
      startIndex = Int(floor((-theta - angle)/anglePerItem))
    }
    //4
    endIndex = min(endIndex, Int(ceil((theta - angle)/anglePerItem)))
    //5
    if (endIndex < startIndex) {
      endIndex = 0
      startIndex = 0
    }
    attributesList = (startIndex...endIndex).map { (i) -> CircularCollectionViewLayoutAttributes in
      return createAttr(index: i)
    }
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return attributesList
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
      return attributesList[indexPath.row]
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
  
//Uncomment the section below to activate snapping behavior
/*
  override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    var finalContentOffset = proposedContentOffset
    let factor = -angleAtExtreme/(collectionViewContentSize().width - CGRectGetWidth(collectionView!.bounds))
    let proposedAngle = proposedContentOffset.x*factor
    let ratio = proposedAngle/anglePerItem
    var multiplier: CGFloat
    if (velocity.x > 0) {
      multiplier = ceil(ratio)
    } else if (velocity.x < 0) {
      multiplier = floor(ratio)
    } else {
      multiplier = round(ratio)
    }
    finalContentOffset.x = multiplier*anglePerItem/factor
    return finalContentOffset
  }
*/
}
