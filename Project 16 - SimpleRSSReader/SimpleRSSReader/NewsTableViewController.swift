//
//  NewsTableViewController.swift
//  SimpleRSSReader
//
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
  
  fileprivate let feedParser = FeedParser()
  fileprivate let feedURL = "http://www.apple.com/main/rss/hotnews/hotnews.rss"
  
  fileprivate var rssItems: [(title: String, description: String, pubDate: String)]?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedRowHeight = 140
    tableView.rowHeight = UITableViewAutomaticDimension
    
    feedParser.parseFeed(feedURL: feedURL) { [weak self] rssItems in
      self?.rssItems = rssItems
      DispatchQueue.main.async {
        self?.tableView.reloadSections(IndexSet(integer: 0), with: .none)
      }
    }
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let rssItems = rssItems else {
      return 0
    }
    return rssItems.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
    
    if let item = rssItems?[indexPath.row] {
      (cell.titleLabel.text, cell.descriptionLabel.text, cell.dateLabel.text) = (item.title, item.description, item.pubDate)
    }
    
    return cell
  }
}
