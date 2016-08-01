//
//  PinterestLayout.swift
//  Pinterest
//
//  Created by Yi Gu on 7/30/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate {
  
  func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath,
                      withWidth:CGFloat) -> CGFloat
  
  func collectionView(collectionView: UICollectionView,
                      heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
}

class PinterestLayout: UICollectionViewLayout {
  var delegate: PinterestLayoutDelegate!
  
  var numberOfColumns = 2
  var cellPadding: CGFloat = 6.0
  
  private var cache = [UICollectionViewLayoutAttributes]()
  
  private var contentHeight: CGFloat  = 0.0
  
  private var contentWidth: CGFloat {
    let insets = collectionView!.contentInset
    return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
  }
  
  override func prepareLayout() {
    if cache.isEmpty {
      // get column width
      let columnWidth = contentWidth / CGFloat(numberOfColumns)
      
      // set up xOffset
      var xOffset = [CGFloat]()
      for column in 0 ..< numberOfColumns {
        xOffset.append(CGFloat(column) * columnWidth)
      }
      
      // set up yOffset
      var column = 0
      var yOffset = [CGFloat](count: numberOfColumns, repeatedValue: 0)
      
      // set up every item
      for item in 0 ..< collectionView!.numberOfItemsInSection(0) {
        let indexPath = NSIndexPath(forItem: item, inSection: 0)
        
        let width = columnWidth - cellPadding * 2
        let photoHeight = delegate.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: width)
        let annotationHeight = delegate.collectionView(collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: width)
        let height = cellPadding + photoHeight + annotationHeight + cellPadding
        let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
        let insetFrame = CGRectInset(frame, cellPadding, cellPadding)
      
        // cache attributes for each item
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.frame = insetFrame
        cache.append(attributes)
        
        //
        contentHeight = max(contentHeight, CGRectGetMaxY(frame))
        yOffset[column] = yOffset[column] + height
        
        column = column >= (numberOfColumns - 1) ? 0 : column + 1
      }
    }
  }
  
  override func collectionViewContentSize() -> CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    for attributes in cache {
      if CGRectIntersectsRect(attributes.frame, rect) {
        layoutAttributes.append(attributes)
      }
    }
    
    return layoutAttributes
  }
  
}
