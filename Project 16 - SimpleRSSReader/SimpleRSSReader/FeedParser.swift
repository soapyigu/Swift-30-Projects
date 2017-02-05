//
//  FeedParser.swift
//  SimpleRSSReader
//
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation

class FeedParser: NSObject, XMLParserDelegate {
  fileprivate var rssItems = [(title: String, description: String, pubDate: String)]()
  
  
}
