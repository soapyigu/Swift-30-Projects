//
//  MasterViewControllerTableViewController.swift
//  PokedexGo
//
//  Created by Yi Gu on 7/10/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
  var pokemons = LibraryAPI.sharedInstance.getPokemons()
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
    cell.awakeFromNib(pokemon.id, name: pokemon.name, pokeImageUrl: pokemon.pokeImgUrl)
    
    return cell
  }
  
}
