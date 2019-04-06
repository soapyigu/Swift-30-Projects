//
//  MainViewController.swift
//  FlickerSearch
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  fileprivate let reuseIdentifier = "FlickrCell"
  fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
  fileprivate let itemsPerRow: CGFloat = 3
  
  fileprivate var searches = [FlickrSearchResults]()
  fileprivate let flickr = Flickr()
  
  // support multiple photos selections
  fileprivate var selectedPhotos = [FlickrPhoto]()
  fileprivate let shareTextLabel = UILabel()
  
  fileprivate var largePhotoIndexPath: IndexPath? {
    didSet {
      var indexPaths = [IndexPath]()
      if let largePhotoIndexPath = largePhotoIndexPath {
        indexPaths.append(largePhotoIndexPath)
      }
      if let oldValue = oldValue {
        indexPaths.append(oldValue)
      }
      
      collectionView.performBatchUpdates({
        self.collectionView.reloadItems(at: indexPaths)
      }) { completed in
        if let largePhotoIndexPath = self.largePhotoIndexPath {
          self.collectionView?.scrollToItem(
            at: largePhotoIndexPath,
            at: .centeredVertically,
            animated: true)
        }
      }
    }
  }
  
  var sharing: Bool = false {
    didSet {
      // reset collectionView and selectedPhotos
      collectionView?.allowsMultipleSelection = sharing
      collectionView?.selectItem(at: nil, animated: true, scrollPosition: UICollectionView.ScrollPosition())
      selectedPhotos.removeAll(keepingCapacity: false)
      
      guard let shareButton = self.navigationItem.rightBarButtonItems?.first else {
        return
      }
      
      guard sharing else {
        navigationItem.setRightBarButtonItems([shareButton], animated: true)
        return
      }
      
      if let _ = largePhotoIndexPath  {
        largePhotoIndexPath = nil
      }
      
      updateSharedPhotoCount()
      let sharingDetailItem = UIBarButtonItem(customView: shareTextLabel)
      navigationItem.setRightBarButtonItems([shareButton,sharingDetailItem], animated: true)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: Selector.longTapHandler)
    collectionView.addGestureRecognizer(longPressGesture)
  }
  
  @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
    switch(gesture.state) {
    case UIGestureRecognizerState.began:
      guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
        break
      }
      collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
    case UIGestureRecognizerState.changed:
      collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
    case UIGestureRecognizerState.ended:
      collectionView.endInteractiveMovement()
    default:
      collectionView.cancelInteractiveMovement()
    }
  }
  
  @IBAction func shareButtonDidTap(_ sender: Any) {
    guard !searches.isEmpty else {
      return
    }
    
    guard !selectedPhotos.isEmpty else {
      sharing = !sharing
      return
    }
    
    guard sharing else  {
      return
    }
    
    // won't be executed when first tapped
    var imageArray = [UIImage]()
    for selectedPhoto in selectedPhotos {
      if let thumbnail = selectedPhoto.thumbnail {
        imageArray.append(thumbnail)
      }
    }
    
    // present activityViewController when imageArray has some selected
    if !imageArray.isEmpty {
      let shareScreen = UIActivityViewController(activityItems: imageArray, applicationActivities: nil)
      shareScreen.completionWithItemsHandler = { _,_,_,_ in
        self.sharing = false
      }
      let popoverPresentationController = shareScreen.popoverPresentationController
      popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
      popoverPresentationController?.permittedArrowDirections = .any
      present(shareScreen, animated: true, completion: nil)
    }
  }
}

extension MainViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return searches.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return searches[section].searchResults.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FlickrPhotoCell
    
    let flickrPhoto = photoForIndexPath(indexPath: indexPath)
    
    cell.activityIndicator.stopAnimating()
    
    guard indexPath == largePhotoIndexPath else {
      cell.imageView.image = flickrPhoto.thumbnail
      return cell
    }
    
    // if already loaded large image
    guard flickrPhoto.largeImage == nil else {
      cell.imageView.image = flickrPhoto.largeImage
      return cell
    }
    
    // start loading large image
    cell.imageView.image = flickrPhoto.thumbnail
    cell.activityIndicator.startAnimating()
    
    flickrPhoto.loadLargeImage { loadedFlickrPhoto, error in
      cell.activityIndicator.stopAnimating()
      
      guard loadedFlickrPhoto.largeImage != nil && error == nil else {
        return
      }
      
      if let cell = collectionView.cellForItem(at: indexPath) as? FlickrPhotoCell,
        indexPath == self.largePhotoIndexPath  {
        cell.imageView.image = loadedFlickrPhoto.largeImage
      }
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionView.elementKindSectionHeader:
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: "FlickrPhotoHeaderView",
                                                                       for: indexPath) as! FlickrPhotoHeaderView
      headerView.titleLabel.text = searches[(indexPath as NSIndexPath).section].searchTerm
      return headerView
    default:
      assert(false, "Unexpected element kind")
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    var sourceResults = searches[sourceIndexPath.section].searchResults
    let flickrPhoto = sourceResults.remove(at: sourceIndexPath.row)
    
    var destinationResults = searches[sourceIndexPath.section].searchResults
    destinationResults.insert(flickrPhoto, at: destinationIndexPath.row)
  }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow
    
    if indexPath == largePhotoIndexPath {
      let flickrPhoto = photoForIndexPath(indexPath: indexPath)
      var size = collectionView.bounds.size
      size.height -= topLayoutGuide.length
      size.height -= (sectionInsets.top + sectionInsets.right)
      size.width -= (sectionInsets.left + sectionInsets.right)
      return flickrPhoto.sizeToFillWidthOfSize(size)
    }
    
    return CGSize(width: widthPerItem, height: widthPerItem)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}

extension MainViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    guard !sharing else {
      return true
    }
    
    largePhotoIndexPath = largePhotoIndexPath == indexPath ? nil : indexPath
    return false
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard sharing else {
      return
    }
    
    let photo = photoForIndexPath(indexPath: indexPath)
    selectedPhotos.append(photo)
    updateSharedPhotoCount()
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    guard sharing else {
      return
    }
    
    let photo = photoForIndexPath(indexPath: indexPath)
    
    if let index = selectedPhotos.firstIndex(of: photo) {
      selectedPhotos.remove(at: index)
      updateSharedPhotoCount()
    }
  }
}

extension MainViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    textField.addSubview(activityIndicator)
    activityIndicator.frame = textField.bounds
    activityIndicator.startAnimating()
    
    flickr.searchFlickrForTerm(textField.text!) {
      results, error in
      activityIndicator.removeFromSuperview()
      
      if let error = error {
        print("Error searching : \(error)")
        return
      }
      
      if let results = results {
        print("Found \(results.searchResults.count) matching \(results.searchTerm)")
        self.searches.insert(results, at: 0)
        
        self.collectionView?.reloadData()
      }
    }
    
    textField.text = nil
    textField.resignFirstResponder()
    return true
  }
}

// MARK: - Private
private extension MainViewController {
  func photoForIndexPath(indexPath: IndexPath) -> FlickrPhoto {
    return searches[indexPath.section].searchResults[indexPath.row]
  }
  
  func updateSharedPhotoCount() {
    shareTextLabel.textColor = themeColor
    shareTextLabel.text = "\(selectedPhotos.count) photos selected"
    shareTextLabel.sizeToFit()
  }
}

private extension Selector {
  static let longTapHandler = #selector(MainViewController.handleLongGesture(gesture:))
}
