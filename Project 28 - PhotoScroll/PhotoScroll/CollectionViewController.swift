/*
* Copyright (c) 2016 Razeware LLC
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

class CollectionViewController: UICollectionViewController {
  fileprivate let reuseIdentifier = "PhotoCell"
  fileprivate let thumbnailSize:CGFloat = 70.0
  fileprivate let sectionInsets = UIEdgeInsets(top: 10, left: 5.0, bottom: 10.0, right: 5.0)
  fileprivate let photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let cell = sender as? UICollectionViewCell,
      let indexPath = collectionView?.indexPath(for: cell),
      let zoomedPhotoViewController = segue.destination as? ZoomedPhotoViewController {
      zoomedPhotoViewController.photoName = "photo\(indexPath.row + 1)"
    }
    
    if let cell = sender as? UICollectionViewCell,
      let indexPath = collectionView?.indexPath(for: cell),
      let photoCommentViewController = segue.destination as? PhotoCommentViewController {
      photoCommentViewController.photoName = "photo\(indexPath.row + 1)"
    }
    
    if let cell = sender as? UICollectionViewCell,
      let indexPath = collectionView?.indexPath(for: cell),
      let managePageViewController = segue.destination as? ManagePageViewController {
      managePageViewController.photos = photos
      managePageViewController.currentIndex = indexPath.row
    }
  }
}

// MARK: UICollectionViewDataSource
extension CollectionViewController {
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
    let fullSizedImage = UIImage(named:photos[indexPath.row])
    cell.imageView.image = fullSizedImage?.thumbnailOfSize(thumbnailSize)
    return cell
  }
}

// MARK:UICollectionViewDelegateFlowLayout
extension CollectionViewController : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: thumbnailSize, height: thumbnailSize)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
}
