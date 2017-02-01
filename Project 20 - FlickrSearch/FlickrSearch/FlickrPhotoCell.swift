//
//  FlickrPhotoCell.swift
//  FlickerSearch
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit

class FlickrPhotoCell: UICollectionViewCell {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override var isSelected: Bool {
    didSet {
      imageView.layer.borderWidth = isSelected ? 10 : 0
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    imageView.layer.borderColor = themeColor.cgColor
    isSelected = false
  }
  
}
