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
  let persistencyManager = PersistencyManager()
  
  fileprivate override init() {
    super.init()
    
    NotificationCenter.default.addObserver(self, selector:#selector(LibraryAPI.downloadImage(_:)), name: NSNotification.Name(rawValue: downloadImageNotification), object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  func getPokemons() -> [Pokemon] {
    return pokemons
  }
  
  func downloadImg(_ url: String) -> (UIImage) {
    let aUrl = URL(string: url)
    let data = try? Data(contentsOf: aUrl!)
    let image = UIImage(data: data!)
    return image!
  }
  
  func downloadImage(_ notification: Notification) {
    // retrieve info from notification
    let userInfo = (notification as NSNotification).userInfo as! [String: AnyObject]
    let pokeImageView = userInfo["pokeImageView"] as! UIImageView?
    let pokeImageUrl = userInfo["pokeImageUrl"] as! String
    
    if let imageViewUnWrapped = pokeImageView {
      imageViewUnWrapped.image = persistencyManager.getImage(URL(string: pokeImageUrl)!.lastPathComponent)
      if imageViewUnWrapped.image == nil {
        
        DispatchQueue.global().async {
          let downloadedImage = self.downloadImg(pokeImageUrl as String)
          DispatchQueue.main.async {
            imageViewUnWrapped.image = downloadedImage
            self.persistencyManager.saveImage(downloadedImage, filename: URL(string: pokeImageUrl)!.lastPathComponent)
          }
        }
      }
    }
  }
}
