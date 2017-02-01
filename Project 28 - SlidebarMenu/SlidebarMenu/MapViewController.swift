//
//  MapViewController.swift
//  SlidebarMenu
//
//  Created by Simon Ng on 24/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
  
  @IBOutlet var menuButton:UIBarButtonItem!
  @IBOutlet weak var extraButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addSideBarMenu(leftMenuButton: menuButton, rightMenuButton: extraButton)
  }
}
