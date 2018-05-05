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
  fileprivate let persistencyManager: PersistencyManager
  fileprivate let httpClient: HTTPClient
  fileprivate let isOnline: Bool
  
  fileprivate override init() {
    persistencyManager = PersistencyManager()
    httpClient = HTTPClient()
    isOnline = false
    
    super.init()
    
    NotificationCenter.default.addObserver(self, selector: .downloadImage, name: .BLDownloadImage, object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: - Public API
  func getAlbums() -> [Album] {
    return persistencyManager.getAlbums()
  }
  
  func addAlbum(_ album: Album, index: Int) {
    persistencyManager.addAlbum(album, index: index)
    if isOnline {
      let _ = httpClient.postRequest("/api/addAlbum", body: album.description)
    }
  }
  
  func deleteAlbum(_ index: Int) {
    persistencyManager.deleteAlbumAtIndex(index)
    if isOnline {
      let _ = httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
    }
  }
  
  @objc func downloadImage(_ notification: Notification) {
    // retrieve info from notification
    guard let userInfo = notification.userInfo,
      let imageView = userInfo["imageView"] as? UIImageView,
      let coverUrl = userInfo["coverUrl"] as? String,
      let filename = URL(string: coverUrl)?.lastPathComponent else {
        return
    }
    
    // get image
    if let savedImage = persistencyManager.getImage(with: filename) {
      imageView.image = savedImage
      return
    }
    
    DispatchQueue.global().async {
      let downloadedImage = self.httpClient.downloadImage(coverUrl as String)
      DispatchQueue.main.async {
        imageView.image = downloadedImage
        self.persistencyManager.saveImage(downloadedImage, filename: URL(string: coverUrl)!.lastPathComponent)
      }
    }
  }
  
  func saveAlbums() {
    persistencyManager.saveAlbums()
  }
}

extension Selector {
  static let downloadImage = #selector(LibraryAPI.downloadImage(_:))
}
