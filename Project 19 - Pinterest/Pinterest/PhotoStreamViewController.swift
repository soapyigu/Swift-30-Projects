//
//  PhotoStreamViewController.swift
//  RWDevCon
//
//  Created by Mic Pringle on 26/02/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoStreamViewController: UICollectionViewController {
  
  var photos = Photo.allPhotos()
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
      layout.delegate = self
    }
    
    if let patternImage = UIImage(named: "Pattern") {
      view.backgroundColor = UIColor(patternImage: patternImage)
    }
    
    collectionView!.backgroundColor = UIColor.clearColor()
    collectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
  }
  
}

extension PhotoStreamViewController {
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AnnotatedPhotoCell", forIndexPath: indexPath) as! AnnotatedPhotoCell
    cell.photo = photos[indexPath.item]
    return cell
  }
}

extension PhotoStreamViewController : PinterestLayoutDelegate {
  func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath,
                      withWidth width: CGFloat) -> CGFloat {
    let photo = photos[indexPath.item]
    let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
    let rect  = AVMakeRectWithAspectRatioInsideRect(photo.image.size, boundingRect)
    return rect.size.height
  }
  
  func collectionView(collectionView: UICollectionView,
                      heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
    let annotationPadding = CGFloat(4)
    let annotationHeaderHeight = CGFloat(17)
    let photo = photos[indexPath.item]
    let font = UIFont(name: "AvenirNext-Regular", size: 10)!
    let commentHeight = photo.heightForComment(font, width: width)
    let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
    return height
  }
}

