//
//  LibraryAPI.swift
//  BlueLibrarySwift
//
//  Created by Yi Gu on 5/6/16.
//  Copyright © 2016 Raywenderlich. All rights reserved.
//

import UIKit

class LibraryAPI: NSObject {
  // MARK: - Singleton Pattern
  static let sharedInstance = LibraryAPI()
  
  // MARK: - Variables
  private let persistencyManager: PersistencyManager
  private let httpClient: HTTPClient
  private let isOnline: Bool
  
  private override init() {
    persistencyManager = PersistencyManager()
    httpClient = HTTPClient()
    isOnline = false
    
    super.init()
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(LibraryAPI.downloadImage(_:)), name: downloadImageNotification, object: nil)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  // MARK: - Public API
  func getAlbums() -> [Album] {
    return persistencyManager.getAlbums()
  }
  
  func addAlbum(album: Album, index: Int) {
    persistencyManager.addAlbum(album, index: index)
    if isOnline {
      httpClient.postRequest("/api/addAlbum", body: album.description)
    }
  }
  
  func deleteAlbum(index: Int) {
    persistencyManager.deleteAlbumAtIndex(index)
    if isOnline {
      httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
    }
  }
  
  func downloadImage(notification: NSNotification) {
    // retrieve info from notification
    let userInfo = notification.userInfo as! [String: AnyObject]
    let imageView = userInfo["imageView"] as! UIImageView?
    let coverUrl = userInfo["coverUrl"] as! String
    
    // get image
    if let imageViewUnWrapped = imageView {
      imageViewUnWrapped.image = persistencyManager.getImage(NSURL(string: coverUrl)!.lastPathComponent!)
      if imageViewUnWrapped.image == nil {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
          let downloadedImage = self.httpClient.downloadImage(coverUrl as String)
          dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            imageViewUnWrapped.image = downloadedImage
            self.persistencyManager.saveImage(downloadedImage, filename: NSURL(string: coverUrl)!.lastPathComponent!)
          })
        })
      }
    }
  }
  
  func saveAlbums() {
    persistencyManager.saveAlbums()
  }
}
