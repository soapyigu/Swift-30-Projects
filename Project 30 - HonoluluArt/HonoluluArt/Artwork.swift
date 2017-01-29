//
//  Artwork.swift
//  HonoluluArt
//
//  Copyright © 2017 Yi Gu. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Artwork: NSObject, MKAnnotation {
  
  /// Title for annotation view.
  let title: String?
  
  /// Location name for subtitle.
  let locationName: String
  
  /// Discipline of the artwork.
  let discipline: String
  
  /// Coordinate data of the artwork location.
  let coordinate: CLLocationCoordinate2D
  
  /// Subtitle for annotation view.
  var subtitle: String? {
    return locationName
  }
  
  init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate
    
    super.init()
  }
  
  func mapItem() -> MKMapItem {
    if let subtitle = subtitle {
      let addressDict = [CNPostalAddressStreetKey: subtitle]
      let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
      
      let mapItem = MKMapItem(placemark: placemark)
      mapItem.name = title
      
      return mapItem
    } else {
      fatalError("Subtitle is nil")
    }
  }
}
