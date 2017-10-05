//
//  PersistencyManager.swift
//  BlueLibrarySwift
//
//  Created by Yi Gu on 5/6/16.
//  Copyright © 2016 Raywenderlich. All rights reserved.
//

import UIKit

class PersistencyManager: NSObject {
  fileprivate var albums = [Album]()
  
  override init() {
    super.init()
    if let data = try? Data(contentsOf: URL(fileURLWithPath: NSHomeDirectory() + "/Documents/albums.bin")) {
      let unarchiveAlbums = NSKeyedUnarchiver.unarchiveObject(with: data) as! [Album]?
      if let unwrappedAlbum = unarchiveAlbums {
        albums = unwrappedAlbum
      }
    } else {
      createPlaceholderAlbum()
    }
  }
  
  func createPlaceholderAlbum() {
    //Dummy list of albums
    let album1 = Album(title: "Opus 12",
                       artist: "Jay Chou",
                       genre: "Pop",
                       coverUrl: "http://a2.att.hudong.com/88/93/19300001321437135520930453813.jpg",
                       year: "2012")
    
    let album2 = Album(title: "Poker Face",
                       artist: "Lady Gaga",
                       genre: "Pop",
                       coverUrl: "https://upload.wikimedia.org/wikipedia/en/3/36/Lady_Gaga_-_Poker_Face.png",
                       year: "2013")
    
    let album3 = Album(title: "What do you mean",
                       artist: "Justin Biber",
                       genre: "Pop",
                       coverUrl: "https://consequenceofsound.files.wordpress.com/2015/08/screen-shot-2015-08-28-at-7-10-21-am.png?w=689",
                       year: "2014")
    
    let album4 = Album(title: "Staring at the Sun",
                       artist: "U2",
                       genre: "Pop",
                       coverUrl: "http://cdn.u2.com/non_secure/images/20090218/discography/staring_at_the_sun2/600.jpg",
                       year: "2010")
    
    let album5 = Album(title: "Iridescent",
                       artist: "Linkin Park",
                       genre: "Pop",
                       coverUrl: "http://img01.deviantart.net/19e2/i/2011/156/3/1/linkin_park_album_art_2_by_jaylathe1-d3i344s.jpg",
                       year: "2000")
    
    albums = [album1, album2, album3, album4, album5]
    saveAlbums()
  }
  
  func saveAlbums() {
    let filename = NSHomeDirectory() + "/Documents/albums.bin"
    let data = NSKeyedArchiver.archivedData(withRootObject: albums)
    try? data.write(to: URL(fileURLWithPath: filename), options: [.atomic])
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
    let path = NSHomeDirectory() + "/Documents/\(filename)"
    guard let data = UIImagePNGRepresentation(image) else {
        return
    }
    try? data.write(to: URL(fileURLWithPath: path), options: [.atomic])
  }
  
  func getImage(_ filename: String) -> UIImage? {
    let path = NSHomeDirectory() + "/Documents/\(filename)"
    
    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .uncachedRead)
      return UIImage(data: data)
    } catch {
      return nil
    }
  }

}
