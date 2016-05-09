//
//  AlbumView.swift
//  BlueLibrarySwift
//
//  Created by Yi Gu on 5/6/16.
//  Copyright © 2016 Raywenderlich. All rights reserved.
//

import UIKit

class AlbumView: UIView {
  private var coverImage: UIImageView!
  private var indicator: UIActivityIndicatorView!
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    commonInit()
  }
  
  init(frame: CGRect, albumCover: String) {
    super.init(frame: frame)
    commonInit()
  }
  
  func commonInit() {
    setupUI()
    setupComponents()
  }
  
  func highlightAlbum(didHightlightView: Bool) {
    if didHightlightView {
      backgroundColor = UIColor.whiteColor()
    } else {
      backgroundColor = UIColor.blackColor()
    }
  }
  
  private func setupUI() {
    backgroundColor = UIColor.blueColor()
  }
  
  private func setupComponents() {
    coverImage = UIImageView(frame: CGRect(x: 5, y: 5, width: frame.size.width - 10, height: frame.size.height - 10))
    addSubview(coverImage)
    
    indicator = UIActivityIndicatorView()
    indicator.center = center
    indicator.activityIndicatorViewStyle = .WhiteLarge
    indicator.startAnimating()
    addSubview(indicator)
  }
}
