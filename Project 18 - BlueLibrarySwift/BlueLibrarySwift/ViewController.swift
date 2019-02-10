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
  @IBOutlet var scroller: HorizontalScrollerView!
  
  // MARK: - Private Variables
  fileprivate var allAlbums = [Album]()
  fileprivate var currentAlbumData: [AlbumData]?
  fileprivate var currentAlbumIndex = 0
  // use a stack to push and pop operation for the undo option
  fileprivate var undoStack: [(Album, Int)] = []
	
  // MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
    func setUI() {
      navigationController?.navigationBar.isTranslucent = false
    }
    
    func setData() {
      currentAlbumIndex = 0
      allAlbums = LibraryAPI.sharedInstance.getAlbums()
    }
    
    func setComponents() {
      dataTable.backgroundView = nil
      loadPreviousState()
      scroller.delegate = self
      scroller.dataSource = self
      reloadScroller()
      scroller.scrollToView(at: currentAlbumIndex)
      
      let undoButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action:Selector.undoAction)
      undoButton.isEnabled = false;
      let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target:nil, action:nil)
      let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target:self, action:Selector.deleteAlbum)
      let toolbarButtonItems = [undoButton, space, trashButton]
      toolbar.setItems(toolbarButtonItems, animated: true)
    }
    
    setUI()
    setData()
    setComponents()
    showDataForAlbum(at: currentAlbumIndex)
    
    NotificationCenter.default.addObserver(self, selector:Selector.saveCurrentState, name: UIApplication.didEnterBackgroundNotification, object: nil)
	}
  
  func showDataForAlbum(at index: Int) {
    if index < allAlbums.count && index > -1 {
      let album = allAlbums[index]
      currentAlbumData = album.tableRepresentation
    } else {
      currentAlbumData = nil
    }
    
    dataTable.reloadData()
  }
  
  // MARK: - Memento Pattern
  @objc func saveCurrentState() {
    // When the user leaves the app and then comes back again, he wants it to be in the exact same state
    // he left it. In order to do this we need to save the currently displayed album.
    // Since it's only one piece of information we can use NSUserDefaults.
    UserDefaults.standard.set(currentAlbumIndex, forKey: Constants.indexRestorationKey)
    LibraryAPI.sharedInstance.saveAlbums()
  }
  
  func loadPreviousState() {
    currentAlbumIndex = UserDefaults.standard.integer(forKey: Constants.indexRestorationKey)
    showDataForAlbum(at: currentAlbumIndex)
  }
  
  // MARK: - Scroller Related
  func reloadScroller() {
    allAlbums = LibraryAPI.sharedInstance.getAlbums()
    if currentAlbumIndex < 0 {
      currentAlbumIndex = 0
    } else if currentAlbumIndex >= allAlbums.count {
      currentAlbumIndex = allAlbums.count - 1
    }
    scroller.reload()
    showDataForAlbum(at: currentAlbumIndex)
  }
  
  func addAlbumAtIndex(_ album: Album,index: Int) {
    LibraryAPI.sharedInstance.addAlbum(album, index: index)
    currentAlbumIndex = index
    reloadScroller()
  }
  
  @objc func deleteAlbum() {
    // get album
    let deletedAlbum : Album = allAlbums[currentAlbumIndex]
    // add to stack
    let undoAction = (deletedAlbum, currentAlbumIndex)
    undoStack.insert(undoAction, at: 0)
    // use library API to delete the album
    LibraryAPI.sharedInstance.deleteAlbum(currentAlbumIndex)
    reloadScroller()
    // enable the undo button
    let barButtonItems = toolbar.items! as [UIBarButtonItem]
    let undoButton : UIBarButtonItem = barButtonItems[0]
    undoButton.isEnabled = true
    // disable trashbutton when no albums left
    if (allAlbums.count == 0) {
      let trashButton : UIBarButtonItem = barButtonItems[2]
      trashButton.isEnabled = false
    }
  }
  
  @objc func undoAction() {
    let barButtonItems = toolbar.items! as [UIBarButtonItem]
    // pop to undo the last one
    if undoStack.count > 0 {
      let (deletedAlbum, index) = undoStack.remove(at: 0)
      addAlbumAtIndex(deletedAlbum, index: index)
    }
    // disable undo button when no albums left
    if undoStack.count == 0 {
      let undoButton : UIBarButtonItem = barButtonItems[0]
      undoButton.isEnabled = false
    }
    // enable the trashButton as there must be at least one album there
    let trashButton : UIBarButtonItem = barButtonItems[2]
    trashButton.isEnabled = true
  }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let albumData = currentAlbumData {
      return albumData.count
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
    
    if let albumData = currentAlbumData {
      cell.textLabel?.text = albumData[(indexPath as NSIndexPath).row].title
      cell.detailTextLabel?.text = albumData[(indexPath as NSIndexPath).row].value
    }
    
    return cell
  }
}

// MARK: - HorizontalScrollerDataSource
extension ViewController: HorizontalScrollerDataSource {
  func numberOfViews(in horizontalScrollerView: HorizontalScrollerView) -> Int {
    return allAlbums.count
  }
  
  func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, viewAt index: Int) -> UIView {
    let album = allAlbums[index]
    
    let albumView = AlbumView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), coverUrl: album.coverUrl)
    
    if currentAlbumIndex == index {
      albumView.highlightAlbum(true)
    } else {
      albumView.highlightAlbum(false)
    }
    return albumView
  }
}

// MARK: - HorizontalScrollerDelegate
extension ViewController: HorizontalScrollerDelegate {
  func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, didSelectViewAt index: Int) {
    let previousAlbumView = scroller.viewAtIndex(currentAlbumIndex) as! AlbumView
    previousAlbumView.highlightAlbum(false)
    
    currentAlbumIndex = index
    
    let albumView = scroller.viewAtIndex(currentAlbumIndex) as! AlbumView
    albumView.highlightAlbum(true)
    
    showDataForAlbum(at: currentAlbumIndex)
  }
}

// MARK: - Constants
fileprivate enum Constants {
  static let cellIdentifier = "Cell"
  static let indexRestorationKey = "currentAlbumIndex"
}

fileprivate extension Selector {
  static let undoAction = #selector(ViewController.undoAction)
  static let deleteAlbum = #selector(ViewController.deleteAlbum)
  static let saveCurrentState = #selector(ViewController.saveCurrentState)
}

