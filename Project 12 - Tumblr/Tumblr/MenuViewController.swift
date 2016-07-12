//
//  MenuViewController.swift
//  Tumblr
//
//  Created by Yi Gu on 7/11/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
  let transitionManager = TransitionManager()
  
  // MARK: - IBOutlets
  @IBOutlet weak var textPostIcon: UIImageView!
  @IBOutlet weak var textPostLabel: UILabel!
  
  @IBOutlet weak var photoPostIcon: UIImageView!
  @IBOutlet weak var photoPostLabel: UILabel!
  
  @IBOutlet weak var quotePostIcon: UIImageView!
  @IBOutlet weak var quotePostLabel: UILabel!
  
  @IBOutlet weak var linkPostIcon: UIImageView!
  @IBOutlet weak var linkPostLabel: UILabel!
  
  @IBOutlet weak var chatPostIcon: UIImageView!
  @IBOutlet weak var chatPostLabel: UILabel!
  
  @IBOutlet weak var audioPostIcon: UIImageView!
  @IBOutlet weak var audioPostLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.transitioningDelegate = self.transitionManager
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
