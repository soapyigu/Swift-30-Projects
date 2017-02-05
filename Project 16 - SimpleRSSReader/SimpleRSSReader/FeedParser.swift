//
//  FeedParser.swift
//  SimpleRSSReader
//
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation

class FeedParser: NSObject, XMLParserDelegate {
  fileprivate var rssItems = [(title: String, description: String, pubDate: String)]()
  
  fileprivate var currentElement = ""
  
  fileprivate var currentTitle = "" {
    didSet {
      currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
  }
  
  fileprivate var currentDescription = "" {
    didSet {
      currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
  }
  
  fileprivate var currentPubDate = "" {
    didSet {
      currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
  }
  
  fileprivate var parseCompletionHandler: (([(title: String, description: String, pubDate: String)]) -> Void)?
  
  func parseFeed(feedURL: String, completionHandler: (([(title: String, description: String, pubDate: String)]) -> Void)?) -> Void {
    
    parseCompletionHandler = completionHandler
    
    guard let feedURL = URL(string:feedURL) else {
      print("feed URL is invalid")
      return
    }
    
    URLSession.shared.dataTask(with: feedURL, completionHandler: { (data, response, error) in
      if let error = error {
        print(error)
        return
      }
      
      guard let data = data else {
        print("No data fetched")
        return
      }
      
      let parser = XMLParser(data: data)
      parser.delegate = self
      parser.parse()
    }).resume()
  }
  
  // MARK: - XMLParser Delegate
  func parserDidStartDocument(_ parser: XMLParser) {
    rssItems = []
  }
  
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    currentElement = elementName
    
    if currentElement == "item" {
      currentTitle = ""
      currentDescription = ""
      currentPubDate = ""
    }
  }
  
  func parser(_ parser: XMLParser, foundCharacters string: String) {
    /// Note: current string may only contain part of info.
    switch currentElement {
    case "title":
      currentTitle += string
    case "description":
      currentDescription += string
    case "pubDate":
      currentPubDate += string
    default:
      break
    }
  }
  
  
}
