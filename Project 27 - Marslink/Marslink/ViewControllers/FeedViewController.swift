//
//  FeedViewController.swift
//  Marslink
//
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import UIKit
import IGListKit

class FeedViewController: UIViewController {
  
  let loader = JournalEntryLoader()
  
  let collectionView: IGListCollectionView = {
    let view = IGListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    view.backgroundColor = UIColor.black
    return view
  }()
  
  lazy var adapter: IGListAdapter = {
    return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    func setupUI() {
      view.addSubview(collectionView)
    }
    
    func setupDateSource() {
      loader.loadLatest()
      
      adapter.collectionView = collectionView
      adapter.dataSource = self
    }
    
    setupUI()
    setupDateSource()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
}

extension FeedViewController: IGListAdapterDataSource {
  /// Populate data to collection view.
  ///
  /// - Parameter listAdapter: The adapter for IGList.
  /// - Returns: Data objects to show on collection view.
  func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
    return loader.entries
  }
  
  /// Asks the section controller for each data object.
  ///
  /// - Parameters:
  ///   - listAdapter: The adapter for IGList.
  ///   - object: The data object.
  /// - Returns: The secion controller for data object.
  func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
    return JournalSectionController()
  }
  
  /// Requests a view when list is empty.
  ///
  /// - Parameter listAdapter: The adapter for IGList.
  /// - Returns: The view shown when list is empty.
  func emptyView(for listAdapter: IGListAdapter) -> UIView? {
    return nil
  }
}

