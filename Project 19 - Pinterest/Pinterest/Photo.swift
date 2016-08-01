//
//  Photo.swift
//  RWDevCon
//
//  Created by Mic Pringle on 04/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class Photo {
  
  class func allPhotos() -> [Photo] {
    var photos = [Photo]()
    if let URL = NSBundle.mainBundle().URLForResource("Photos", withExtension: "plist") {
      if let photosFromPlist = NSArray(contentsOfURL: URL) {
        for dictionary in photosFromPlist {
          let photo = Photo(dictionary: dictionary as! NSDictionary)
          photos.append(photo)
        }
      }
    }
    return photos
  }
  
  var caption: String
  var comment: String
  var image: UIImage
  
  init(caption: String, comment: String, image: UIImage) {
    self.caption = caption
    self.comment = comment
    self.image = image
  }
  
  convenience init(dictionary: NSDictionary) {
    let caption = dictionary["Caption"] as? String
    let comment = dictionary["Comment"] as? String
    let photo = dictionary["Photo"] as? String
    let image = UIImage(named: photo!)?.decompressedImage
    self.init(caption: caption!, comment: comment!, image: image!)
  }
  
  func heightForComment(font: UIFont, width: CGFloat) -> CGFloat {
    let rect = NSString(string: comment).boundingRectWithSize(CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
    return ceil(rect.height)
  }
  
}
