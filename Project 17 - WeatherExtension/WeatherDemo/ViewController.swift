//
//  ViewController.swift
//  WeatherDemo
//
//  Created by Simon Ng on 9/1/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cityLabel:UILabel!
    @IBOutlet weak var countryLabel:UILabel!
    @IBOutlet weak var weatherLabel:UILabel!
    @IBOutlet weak var temperatureLabel:UILabel!


    var city = "Paris"
    var country = "France"
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        weatherLabel.text = ""
        temperatureLabel.text = ""
        
        displayCurrentWeather()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayCurrentWeather() {
        // Update location
        cityLabel.text = city
        countryLabel.text = country
        
        // Invoke weather service to get the weather data
        WeatherService.sharedWeatherService().getCurrentWeather(city + "," + country, completion: { (data) -> () in
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                if let weatherData = data {
                    self.weatherLabel.text = weatherData.weather.capitalizedString
                    self.temperatureLabel.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
                }
            })
        })
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    }
    
    @IBAction func updateWeatherInfo(segue: UIStoryboardSegue) {
        let sourceViewController = segue.sourceViewController as! LocationTableViewController
        var selectedLocation = sourceViewController.selectedLocation.characters.split { $0 == "," }.map { String($0) }
        city = selectedLocation[0]
        country = selectedLocation[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        displayCurrentWeather()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "showLocations" {
            let destinationController = segue.destinationViewController as! UINavigationController
            let locationTableViewController = destinationController.viewControllers[0] as! LocationTableViewController
            locationTableViewController.selectedLocation = "\(city), \(country)"
        }
    }

}

