//
//  LibraryAPI.swift
//  PokedexGo
//
//  Created by Yi Gu on 7/10/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import UIKit

class LibraryAPI: NSObject {
  static let sharedInstance = LibraryAPI()
  
  private override init() {
    super.init()
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(LibraryAPI.downloadImage(_:)), name: downloadImageNotification, object: nil)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  func getPokemons() -> [Pokemon] {
    return pokemons
  }

  func downloadImg(url: String) -> (UIImage) {
    let aUrl = NSURL(string: url)
    let data = NSData(contentsOfURL: aUrl!)
    let image = UIImage(data: data!)
    return image!
  }

  func downloadImage(notification: NSNotification) {
    // retrieve info from notification
    let userInfo = notification.userInfo as! [String: AnyObject]
    let pokeImageView = userInfo["pokeImageView"] as! UIImageView?
    let pokeImageUrl = userInfo["pokeImageUrl"] as! String
    
    // get image
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
      let downloadedImage = self.downloadImg(pokeImageUrl)
      dispatch_sync(dispatch_get_main_queue(), { () -> Void in
        pokeImageView?.image = downloadedImage
      })
    })
  }
  

}
