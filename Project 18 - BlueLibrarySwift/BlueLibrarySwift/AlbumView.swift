//
//  AlbumView.swift
//  BlueLibrarySwift
//
//  Created by Yi Gu on 5/6/16.
//  Copyright © 2016 Raywenderlich. All rights reserved.
//

import UIKit

class AlbumView: UIView {
  fileprivate var coverImageView: UIImageView!
  fileprivate var indicatorView: UIActivityIndicatorView!
  fileprivate var valueObservation: NSKeyValueObservation!
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    commonInit()
  }
  
  init(frame: CGRect, albumCover: String) {
    super.init(frame: frame)
    commonInit()
    setupNotification(albumCover)
  }
  
  func commonInit() {
    setupUI()
    setupComponents()
  }
  
  func highlightAlbum(_ didHightlightView: Bool) {
    if didHightlightView {
      backgroundColor = UIColor.white
    } else {
      backgroundColor = UIColor.black
    }
  }
  
  fileprivate func setupUI() {
    backgroundColor = UIColor.blue
  }
  
  fileprivate func setupComponents() {
    coverImageView = UIImageView(frame: CGRect(x: 5, y: 5, width: frame.size.width - 10, height: frame.size.height - 10))
    valueObservation = coverImageView.observe(\.image, options: [.new]) { [unowned self] observed, change in
      if change.newValue is UIImage {
        self.indicatorView.stopAnimating()
      }
    }
    
    addSubview(coverImageView)
    
    indicatorView = UIActivityIndicatorView()
    indicatorView.center = center
    indicatorView.activityIndicatorViewStyle = .whiteLarge
    indicatorView.startAnimating()
    addSubview(indicatorView)
  }
  
  fileprivate func setupNotification(_ albumCover: String) {
    NotificationCenter.default.post(name: .BLDownloadImage, object: self, userInfo: ["imageView":coverImageView, "coverUrl" : albumCover])
  }
}

extension Notification.Name {
  static let BLDownloadImage = Notification.Name(downloadImageNotification)
}
