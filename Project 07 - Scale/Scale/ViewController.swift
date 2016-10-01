//
//  ViewController.swift
//  Scale
//
//  Created by Yi Gu on 04/22/15.
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  // MARK: - IBOutlets
  @IBOutlet weak var forceLabel: UILabel!
  
  // MARK: - init
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - UITouch
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    // check only one object in touches
    guard let touch = touches.first else {
      return
    }
    
    // check if device is 3D Touch capable
    if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
      if touch.force >= touch.maximumPossibleForce {
        forceLabel.text = "385+ g"
      } else {
        let force = touch.force / touch.maximumPossibleForce
        let grams = Int(force * 385)
        forceLabel.text = "\(grams) g"
      }
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    forceLabel.text = "0 g"
  }
  
}

