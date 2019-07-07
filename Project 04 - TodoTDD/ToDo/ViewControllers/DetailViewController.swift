//
//  DetailViewController.swift
//  ToDo
//
//  Created by gu, yi on 10/2/18.
//  Copyright © 2018 gu, yi. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
  
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var mapView: MKMapView!
  @IBOutlet var locationLabel: UILabel!
  
  var item: ToDoItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let item = item else {
      return
    }
    
    titleLabel.text = item.title
    
    if let location = item.location {
      locationLabel.text = location.name
      if let cooridnate = location.coordinate {
        centerMapOnLocation(with: cooridnate)
      }
    }
  }
  
  private func centerMapOnLocation(with coordinate: CLLocationCoordinate2D) {
    let regionRadius: CLLocationDistance = 1000
    
    let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    mapView.setRegion(coordinateRegion, animated: true)
  }
}
