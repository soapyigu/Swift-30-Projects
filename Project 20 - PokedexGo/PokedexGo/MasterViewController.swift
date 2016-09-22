//
//  MasterViewControllerTableViewController.swift
//  PokedexGo
//
//  Created by Yi Gu on 7/10/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import UIKit

protocol PokemonSelectionDelegate: class {
  func pokemonSelected(_ newPokemon: Pokemon)
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
  
  func filterContentForSearchText(_ searchText: String, scope: String = "All") {
    filteredPokemons = pokemons.filter { pokemon in
      return pokemon.name.lowercased().contains(searchText.lowercased()) || String(pokemon.id).lowercased().contains(searchText.lowercased())
    }
    
    tableView.reloadData()
  }
  
  // MARK: - UITableViewDelegate
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 140
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let pokemon: Pokemon
    
    if searchController.isActive && searchController.searchBar.text != "" {
      pokemon = filteredPokemons[(indexPath as NSIndexPath).row]
    } else {
      pokemon = self.pokemons[(indexPath as NSIndexPath).row]
    }

    delegate?.pokemonSelected(pokemon)
    
    if let detailViewController = self.delegate as? DetailViewController {
      splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
    }
  }
  
  // MARK: - UITableViewDataSource
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.isActive && searchController.searchBar.text != "" {
      return filteredPokemons.count
    }
    return pokemons.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let identifier = "Cell"
    
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MasterTableViewCell
    let pokemon: Pokemon
    
    if searchController.isActive && searchController.searchBar.text != "" {
      pokemon = filteredPokemons[(indexPath as NSIndexPath).row]
    } else {
      pokemon = self.pokemons[(indexPath as NSIndexPath).row]
    }
    
    cell.awakeFromNib(pokemon.id, name: pokemon.name, pokeImageUrl: pokemon.pokeImgUrl)
    
    return cell
  }
}

extension MasterViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text!)
  }
}
