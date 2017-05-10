/**
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

class ClassicFeedViewController: UIViewController {
  
  let loader = JournalEntryLoader()
  let solFormatter = SolFormatter()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    view.backgroundColor = UIColor.black
    view.alwaysBounceVertical = true
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.register(JournalEntryCell.self, forCellWithReuseIdentifier: "JournalEntryCell")
    collectionView.register(JournalEntryDateCell.self, forCellWithReuseIdentifier: "JournalEntryDateCell")
    collectionView.dataSource = self
    collectionView.delegate = self
    view.addSubview(collectionView)
    
    loader.loadLatest()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
}

//MARK: UICollectionViewDataSource
extension ClassicFeedViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return loader.entries.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let identifier = (indexPath as NSIndexPath).item == 0 ? "JournalEntryDateCell" : "JournalEntryCell"
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    let entry = loader.entries[(indexPath as NSIndexPath).section]
    if let cell = cell as? JournalEntryDateCell {
      cell.label.text = "SOL \(solFormatter.sols(fromDate: entry.date))"
    } else if let cell = cell as? JournalEntryCell {
      cell.label.text = entry.text
    }
    return cell
  }
}

//MARK: UICollectionViewDelegateFlowLayout
extension ClassicFeedViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.bounds.width
    if indexPath.item == 0 {
      return CGSize(width: width, height: 30)
    } else {
      let entry = loader.entries[indexPath.section]
      return JournalEntryCell.cellSize(width: width, text: entry.text)
    }
  }
}
