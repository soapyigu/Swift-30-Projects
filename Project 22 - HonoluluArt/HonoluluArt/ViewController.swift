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
  
  fileprivate let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
  fileprivate let regionRadius: CLLocationDistance = 1000
  
  fileprivate var artworks = [Artwork]()
  fileprivate var locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    /// Set up map.
    mapView.delegate = self
    centerMapOnLocation(location: initialLocation)
    loadInitialData()
    
    mapView.addAnnotations(artworks)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    checkLocationAuthorizationStatus()
  }
  
  fileprivate func checkLocationAuthorizationStatus() {
    if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
      mapView.showsUserLocation = true
    } else {
      locationManager.requestWhenInUseAuthorization()
    }
  }
  
  fileprivate func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
    mapView.setRegion(coordinateRegion, animated: true)
  }
  
  fileprivate func loadInitialData() {
    let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json");
    var data: Data?
    do {
      data = try Data(contentsOf: URL(fileURLWithPath: fileName!), options: NSData.ReadingOptions(rawValue: 0))
    } catch _ {
      data = nil
    }
    
    if let data = data {
      do {
        if let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject],
          let jsonData = JSONValue.fromObject(jsonObject)?["data"]?.array {
          for artworkJSON in jsonData {
            if let artworkJSON = artworkJSON.array,
              let artwork = Artwork.fromJSON(json: artworkJSON) {
              artworks.append(artwork)
            }
          }
        }
      } catch let error as NSError {
        print(error.description)
      }
    }
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
        view?.pinTintColor = annotation.pinColor()
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
