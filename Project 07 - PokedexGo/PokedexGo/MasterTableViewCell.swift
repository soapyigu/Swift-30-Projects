//
//  MasterTableViewCell.swift
//  PokedexGo
//
//  Created by Yi Gu on 7/10/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import UIKit

class MasterTableViewCell: UITableViewCell {
  @IBOutlet weak var idLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var pokeImageView: UIImageView!
  
  fileprivate var indicator: UIActivityIndicatorView!
  
  func awakeFromNib(_ id: Int, name: String, pokeImageUrl: String) {
    super.awakeFromNib()
    setupUI(id, name: name)
    setupNotification(pokeImageUrl)
  }
  
  deinit {
    pokeImageView.removeObserver(self, forKeyPath: "image")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  fileprivate func setupUI(_ id: Int, name: String) {
    idLabel.text = NSString(format: "#%03d", id) as String
    nameLabel.text = name
    pokeImageView.image = UIImage(named: "default_img")
    
    indicator = UIActivityIndicatorView()
    indicator.center = CGPoint(x: pokeImageView.bounds.midX, y: pokeImageView.bounds.midY)
    indicator.activityIndicatorViewStyle = .whiteLarge
    indicator.startAnimating()
    pokeImageView.addSubview(indicator)
    
    pokeImageView.addObserver(self, forKeyPath: "image", options: [], context: nil)
  }
  
  fileprivate func setupNotification(_ pokeImageUrl: String) {
    NotificationCenter.default.post(name: Notification.Name(rawValue: downloadImageNotification), object: self, userInfo: ["pokeImageView":pokeImageView, "pokeImageUrl" : pokeImageUrl])
  }

  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "image" {
      indicator.stopAnimating()
    }
  }
}
