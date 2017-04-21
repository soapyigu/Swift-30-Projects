//
//  ViewController.swift
//  Animations
//
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

let headerHeight = 50.0
let segueDetailIdentifier = "toAnimateDetail"
let duration = 1.5

class ViewController: UIViewController {
  // MARK: - IBOutlets
  @IBOutlet weak var masterTableView: UITableView!
  
  // MARK: - Variables
  fileprivate let items = ["2-Color", "Simple 2D Rotation", "Multicolor", "Multi Point Position", "BezierCurve Position",
                       "Color and Frame Change", "View Fade In", "Pop"]
  
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    animateTable()
  }
  
  func animateTable() {
    masterTableView.reloadData()
    
    let cells = masterTableView.visibleCells
    let tableHeight = masterTableView.bounds.size.height
    
    // move all cells to the bottom of the screen
    for cell in cells {
      cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
    }
    
    // move all cells from bottom to the right place
    var index = 0
    for cell in cells {
      UIView.animate(withDuration: duration, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
        cell.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: nil)
      index += 1
    }
  }
  
  // MARK: - Segue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == segueDetailIdentifier {
      let detailView = segue.destination as! DetailViewController
      let indexPath = masterTableView.indexPathForSelectedRow
      
      if let indexPath = indexPath {
        detailView.barTitle = self.items[(indexPath as NSIndexPath).row]
      }
    }
  }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return CGFloat(headerHeight)
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Basic Animations"
  }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "cell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    
    cell.textLabel?.text = self.items[(indexPath as NSIndexPath).row]
    
    return cell
  }
}

