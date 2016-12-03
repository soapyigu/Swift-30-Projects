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

  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    // Do any additional setup after loading the view.
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
    cell.backgroundColor = UIColor.white
    cell.imageView.image = flickrPhoto.thumbnail
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionElementKindSectionHeader:
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: "FlickrPhotoHeaderView",
                                                                       for: indexPath) as! FlickrPhotoHeaderView
      headerView.titleLabel.text = searches[(indexPath as NSIndexPath).section].searchTerm
      return headerView
    default:
      assert(false, "Unexpected element kind")
    }
  }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow
    
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

extension MainViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
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
    return searches[(indexPath as NSIndexPath).section].searchResults[(indexPath as NSIndexPath).row]
  }
}
