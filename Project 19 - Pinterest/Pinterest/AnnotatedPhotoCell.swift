//
//  AnnotatedPhotoCell.swift
//  RWDevCon
//
//  Created by Mic Pringle on 26/02/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class AnnotatedPhotoCell: UICollectionViewCell {
  
  @IBOutlet fileprivate weak var imageView: UIImageView!
  @IBOutlet fileprivate weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
  @IBOutlet fileprivate weak var captionLabel: UILabel!
  @IBOutlet fileprivate weak var commentLabel: UILabel!
  
  var photo: Photo? {
    didSet {
      if let photo = photo {
        imageView.image = photo.image
        captionLabel.text = photo.caption
        commentLabel.text = photo.comment
      }
    }
  }
  
  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
    if let attributes = layoutAttributes as? PinterestLayoutAttributes {
      imageViewHeightLayoutConstraint.constant = attributes.photoHeight
    }
  }
}
