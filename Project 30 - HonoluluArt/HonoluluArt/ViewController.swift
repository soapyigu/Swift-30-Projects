//
//  ViewController.swift
//  HonoluluArt
//
//  Copyright © 2017 Yi Gu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  
  /// Location shows on map when app starts up.
  let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
  
  /// Region radius for map.
  let regionRadius: CLLocationDistance = 1000
  
  /// Artwork to show as annotation on map.
  let artwork = Artwork(title: "King David Kalakaua",
                        locationName: "Waikiki Gateway Park",
                        discipline: "Sculpture",
                        coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.delegate = self
    
    centerMapOnLocation(location: initialLocation)
    mapView.addAnnotation(artwork)
  }
  
  fileprivate func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
    mapView.setRegion(coordinateRegion, animated: true)
  }
}

extension ViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    var view: MKPinAnnotationView?
    
    if let annotation = annotation as? Artwork {
      let identifier = "pin"
      
      if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        as? MKPinAnnotationView {
        dequeuedView.annotation = annotation
        view = dequeuedView
      } else {
        view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        view?.canShowCallout = true
        view?.calloutOffset = CGPoint(x: -5, y: 5)
        view?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
      }
    }
    
    return view
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    let location = view.annotation as! Artwork
    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
    location.mapItem().openInMaps(launchOptions: launchOptions)
  }
}
