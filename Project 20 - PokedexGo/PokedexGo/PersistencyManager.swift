//
//  PersistencyManager.swift
//  PokedexGo
//
//  Created by Yi Gu on 7/14/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import UIKit

class PersistencyManager: NSObject {
  func saveImage(image: UIImage, filename: String) {
    let path = NSHomeDirectory().stringByAppendingString("/Documents/\(filename)")
    let data = UIImagePNGRepresentation(image)
    data!.writeToFile(path, atomically: true)
  }
  
  func getImage(filename: String) -> UIImage? {
    let path = NSHomeDirectory().stringByAppendingString("/Documents/\(filename)")
    
    do {
      let data = try NSData(contentsOfFile: path, options: .UncachedRead)
      return UIImage(data: data)
    } catch {
      return nil
    }
  }
}
