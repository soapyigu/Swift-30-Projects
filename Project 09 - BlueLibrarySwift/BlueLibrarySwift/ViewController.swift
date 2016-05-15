/*
* Copyright (c) 2014 Razeware LLC
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

class ViewController: UIViewController {

  // MARK: - IBOutlet
	@IBOutlet var dataTable: UITableView!
	@IBOutlet var toolbar: UIToolbar!
  @IBOutlet var scroller: HorizontalScroller!
  
  // MARK: - Private Variables
  private var allAlbums = [Album]()
  private var currentAlbumData : (titles:[String], values:[String])?
  private var currentAlbumIndex = 0
	
  // MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
    setupUI()
    setupData()
    setupComponents()
    showDataForAlbum(currentAlbumIndex)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(ViewController.saveCurrentState), name: UIApplicationDidEnterBackgroundNotification, object: nil)
	}
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  func setupUI() {
    navigationController?.navigationBar.translucent = false
  }
  
  func setupData() {
    currentAlbumIndex = 0
    allAlbums = LibraryAPI.sharedInstance.getAlbums()
  }
  
  func setupComponents() {
    dataTable.backgroundView = nil
    loadPreviousState()
    scroller.delegate = self
    reloadScroller()
  }
  
  func showDataForAlbum(index: Int) {
    if index < allAlbums.count && index > -1 {
      let album = allAlbums[index]
      currentAlbumData = album.ae_tableRepresentation()
    } else {
      currentAlbumData = nil
    }
    
    if let dataTable = dataTable {
      dataTable.reloadData()
    }
  }
  
  //MARK: - Memento Pattern
  func saveCurrentState() {
    // When the user leaves the app and then comes back again, he wants it to be in the exact same state
    // he left it. In order to do this we need to save the currently displayed album.
    // Since it's only one piece of information we can use NSUserDefaults.
    NSUserDefaults.standardUserDefaults().setInteger(currentAlbumIndex, forKey: "currentAlbumIndex")
  }
  
  func loadPreviousState() {
    currentAlbumIndex = NSUserDefaults.standardUserDefaults().integerForKey("currentAlbumIndex")
    showDataForAlbum(currentAlbumIndex)
  }
  
  func reloadScroller() {
    allAlbums = LibraryAPI.sharedInstance.getAlbums()
    if currentAlbumIndex < 0 {
      currentAlbumIndex = 0
    } else if currentAlbumIndex >= allAlbums.count {
      currentAlbumIndex = allAlbums.count - 1
    }
    scroller.reload()
    showDataForAlbum(currentAlbumIndex)
  }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let albumData = currentAlbumData {
      return albumData.titles.count
    } else {
      return 0
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier = "Cell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
    
    if let albumData = currentAlbumData {
      cell.textLabel?.text = albumData.titles[indexPath.row]
      cell.detailTextLabel?.text = albumData.values[indexPath.row]
    }
    
    return cell
  }
}

// MARK: - HorizontalScroller
extension ViewController: HorizontalScrollerDelegate {
  func numberOfViewsForHorizontalScroller(scroller: HorizontalScroller) -> Int {
    return allAlbums.count
  }
  
  func horizontalScrollerViewAtIndex(scroller: HorizontalScroller, index: Int) -> UIView {
    let album = allAlbums[index]
    let albumView = AlbumView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), albumCover: album.coverUrl)
    
    if currentAlbumIndex == index {
      albumView.highlightAlbum(true)
    } else {
      albumView.highlightAlbum(false)
    }
    
    return albumView
  }
  
  func horizontalScrollerClickedViewAtIndex(scroller: HorizontalScroller, index: Int) {
    let previousAlbumView = scroller.viewAtIndex(currentAlbumIndex) as! AlbumView
    previousAlbumView.highlightAlbum(false)
    
    currentAlbumIndex = index
    
    let albumView = scroller.viewAtIndex(currentAlbumIndex) as! AlbumView
    albumView.highlightAlbum(true)
    
    showDataForAlbum(currentAlbumIndex)
  }
  
  func initialViewIndex(scroller: HorizontalScroller) -> Int {
    return currentAlbumIndex
  }
}

