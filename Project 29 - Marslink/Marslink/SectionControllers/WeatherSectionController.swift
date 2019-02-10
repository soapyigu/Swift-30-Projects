//
//  WeatherSectionController.swift
//  Marslink
//
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import UIKit
import IGListKit

class WeatherSectionController: IGListSectionController {
  
  fileprivate var expanded = false
  fileprivate var weather: Weather!
  
  override init() {
    super.init()
    inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
  }
}

extension WeatherSectionController: IGListSectionType {
  func numberOfItems() -> Int {
    return expanded ? 5 : 1
  }
  
  func sizeForItem(at index: Int) -> CGSize {
    guard let context = collectionContext else {
      return .zero
    }
    let width = context.containerSize.width
    
    if index == 0 {
      return CGSize(width: width, height: 70)
    } else {
      return CGSize(width: width, height: 40)
    }
  }
  
  func cellForItem(at index: Int) -> UICollectionViewCell {
    let summaryCell = collectionContext!.dequeueReusableCell(of: WeatherSummaryCell.self, for: self, at: index) as! WeatherSummaryCell
    let detailCell = collectionContext!.dequeueReusableCell(of: WeatherDetailCell.self, for: self, at: index) as! WeatherDetailCell
    let detailInfo = [("Sunrise", weather.sunrise), ("Sunset", weather.sunset), ("High", "\(weather.high) C"), ("Low", "\(weather.low) C")]
    
    if index == 0 {
      summaryCell.setExpanded(expanded)
      return summaryCell
    } else {
      detailCell.titleLabel.text = detailInfo[index - 1].0
      detailCell.detailLabel.text = detailInfo[index - 1].1
      return detailCell
    }
  }
  
  func didUpdate(to object: Any) {
    weather = object as? Weather
  }
  
  func didSelectItem(at index: Int) {
    expanded = !expanded
    collectionContext?.reload(self)
  }
}
