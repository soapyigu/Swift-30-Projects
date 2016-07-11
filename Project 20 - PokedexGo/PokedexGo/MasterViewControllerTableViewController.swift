//
//  MasterViewControllerTableViewController.swift
//  PokedexGo
//
//  Created by Yi Gu on 7/10/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import UIKit

class MasterViewControllerTableViewController: UITableViewController {
  private var pokemons = [Pokemon]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    pokemons = LibraryAPI.sharedInstance.getPokemons()
  }
  
  // MARK: - UITableViewDelegate
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 140
  }
  
  // MARK: - UITableViewDataSource
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pokemons.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let identifier = "Cell"
    
    let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! MasterTableViewCell
    let pokemon = pokemons[indexPath.row]
    let idStr = indexPath.row + 1 < 10 ? "#00\(indexPath.row + 1)" : indexPath.row < 100 ? "#0\(indexPath.row + 1)" : "#\(indexPath.row + 1)"
    
    cell.awakeFromNib(idStr, name: pokemon.name, pokeImageUrl: pokemon.pokeImgUrl)
    
    return cell
  }
  
}
