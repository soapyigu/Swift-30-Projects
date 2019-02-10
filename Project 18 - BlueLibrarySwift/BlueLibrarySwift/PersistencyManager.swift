//
//  PersistencyManager.swift
//  BlueLibrarySwift
//
//  Created by Yi Gu on 5/6/16.
//  Copyright © 2016 Raywenderlich. All rights reserved.
//

import UIKit

final class PersistencyManager: NSObject {
  fileprivate var albums = [Album]()
  fileprivate var cache: URL {
    return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
  }
  private var documents: URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
  private enum Filenames {
    static let Albums = "albums.json"
  }
  
  override init() {
    super.init()
    
    let savedURL = documents.appendingPathComponent(Filenames.Albums)
    var data = try? Data(contentsOf: savedURL)
    if data == nil, let bundleURL = Bundle.main.url(forResource: Filenames.Albums, withExtension: nil) {
      data = try? Data(contentsOf: bundleURL)
    }
    
    if let albumData = data,
      let decodedAlbums = try? JSONDecoder().decode([Album].self, from: albumData) {
      albums = decodedAlbums
      saveAlbums()
    }
  }
  
  func saveAlbums() {
    let url = documents.appendingPathComponent(Filenames.Albums)
    let encoder = JSONEncoder()
    guard let encodedData = try? encoder.encode(albums) else {
      return
    }
    try? encodedData.write(to: url)
  }
  
  func getAlbums() -> [Album] {
    return albums
  }
  
  func addAlbum(_ album: Album, index: Int) {
    if albums.count >= index {
      albums.insert(album, at: index)
    } else {
      albums.append(album)
    }
  }
  
  func deleteAlbumAtIndex(_ index: Int) {
    albums.remove(at: index)
  }
  
  func saveImage(_ image: UIImage, filename: String) {
    let url = cache.appendingPathComponent(filename)
    guard let data = image.pngData() else {
      return
    }
    try? data.write(to: url)
  }
  
  func getImage(with filename: String) -> UIImage? {
    let url = cache.appendingPathComponent(filename)
    guard let data = try? Data(contentsOf: url) else {
      return nil
    }
    return UIImage(data: data)
  }
}
