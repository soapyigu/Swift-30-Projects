//
//  MasterViewControllerTableViewController.swift
//  PokedexGo
//
//  Created by Yi Gu on 7/10/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import UIKit

protocol PokemonSelectionDelegate: class {
  func pokemonSelected(newPokemon: Pokemon)
}

class MasterViewController: UITableViewController {
  var pokemons = LibraryAPI.sharedInstance.getPokemons()
  var filteredPokemons = [Pokemon]()
  weak var delegate: PokemonSelectionDelegate?
  
  let searchController = UISearchController(searchResultsController: nil)
  
  override func viewDidLoad() {
    setupUI()
    
    super.viewDidLoad()
  }
  
  func setupUI() {
    self.title = "精灵列表"
    
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    definesPresentationContext = true
    tableView.tableHeaderView = searchController.searchBar
  }
  
  func filterContentForSearchText(searchText: String, scope: String = "All") {
    filteredPokemons = pokemons.filter { pokemon in
      return pokemon.name.lowercaseString.containsString(searchText.lowercaseString) || String(pokemon.id).lowercaseString.containsString(searchText.lowercaseString)
    }
    
    tableView.reloadData()
  }
  
  // MARK: - UITableViewDelegate
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 140
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let pokemon = self.pokemons[indexPath.row]
    delegate?.pokemonSelected(pokemon)
    
    if let detailViewController = self.delegate as? DetailViewController {
      splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
    }
  }
  
  // MARK: - UITableViewDataSource
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.active && searchController.searchBar.text != "" {
      return filteredPokemons.count
    }
    return pokemons.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let identifier = "Cell"
    
    let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! MasterTableViewCell
    let pokemon: Pokemon
    
    if searchController.active && searchController.searchBar.text != "" {
      pokemon = filteredPokemons[indexPath.row]
    } else {
      pokemon = self.pokemons[indexPath.row]
    }
    
    cell.awakeFromNib(pokemon.id, name: pokemon.name, pokeImageUrl: pokemon.pokeImgUrl)
    
    return cell
  }
}

extension MasterViewController: UISearchResultsUpdating {
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text!)
  }
}
