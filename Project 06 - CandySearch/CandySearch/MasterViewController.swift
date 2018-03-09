/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class MasterViewController: UITableViewController {
  
  // MARK: - Properties
  var detailViewController: DetailViewController? = nil
  var candies = [Candy]()
  var filteredCandies = [Candy]()
  let searchController = UISearchController(searchResultsController: nil)
  
  // MARK: - View Setup
  override func viewDidLoad() {
    super.viewDidLoad()
    
    candies = [
        Candy(category:"Chocolate", name:"Chocolate Bar"),
        Candy(category:"Chocolate", name:"Chocolate Chip"),
        Candy(category:"Chocolate", name:"Dark Chocolate"),
        Candy(category:"Hard", name:"Lollipop"),
        Candy(category:"Hard", name:"Candy Cane"),
        Candy(category:"Hard", name:"Jaw Breaker"),
        Candy(category:"Other", name:"Caramel"),
        Candy(category:"Other", name:"Sour Chew"),
        Candy(category:"Other", name:"Gummi Bear")
    ]
    
    setupSearchController()

    if let splitViewController = splitViewController {
      let controllers = splitViewController.viewControllers
      detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
    }
  }
  
  // MARK: - Search Controller Setup
  func setupSearchController () {
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    definesPresentationContext = true
    searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
    searchController.searchBar.delegate = self
    if #available(iOS 11, *) {
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.isActive = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
    } else {
        tableView.tableHeaderView = searchController.searchBar
    }
  }
  
  func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCandies = candies.filter { candy in
            if !(candy.category == scope) && scope != "All" {
                return false
            }
            
            return candy.name.lowercased().contains(searchText.lowercased()) || searchText == ""
        }
        
        tableView.reloadData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
    super.viewWillAppear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Table View
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.isActive {
      return filteredCandies.count
    }
    return candies.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    let candy: Candy
    if searchController.isActive {
      candy = filteredCandies[(indexPath as NSIndexPath).row]
    } else {
      candy = candies[(indexPath as NSIndexPath).row]
    }
    cell.textLabel!.text = candy.name
    cell.detailTextLabel!.text = candy.category
    return cell
  }
  
  // MARK: - Segues
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let candy: Candy
        if searchController.isActive {
          candy = filteredCandies[(indexPath as NSIndexPath).row]
        } else {
          candy = candies[(indexPath as NSIndexPath).row]
        }
        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
        controller.detailCandy = candy
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true
      }
    }
  }
  
}

extension MasterViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    filterContentForSearchText(searchController.searchBar.text!, scope: scope)
  }
}

extension MasterViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
  }
}

