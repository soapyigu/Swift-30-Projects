//
//  WeatherService.swift
//  WeatherDemo
//
//  Created by Simon Ng on 12/1/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation

class WeatherService {
    typealias WeatherDataCompletionBlock = (data: WeatherData?) -> ()

    let openWeatherBaseAPI = "http://api.openweathermap.org/data/2.5/weather?appid=bd82977b86bf27fb59a04b61b657fb6f&units=metric&q="
    let urlSession:NSURLSession = NSURLSession.sharedSession()

    class func sharedWeatherService() -> WeatherService {
        return _sharedWeatherService
    }
    
    func getCurrentWeather(location:String, completion: WeatherDataCompletionBlock) {
        let openWeatherAPI = openWeatherBaseAPI + location.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        print(openWeatherAPI)
        let request = NSURLRequest(URL: NSURL(string: openWeatherAPI)!)
        let weatherData = WeatherData()
        
        let task = urlSession.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data else {
                if error != nil {
                    print(error)
                }
                
                return
            }
            
            // Retrieve JSON data
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? NSDictionary
                
                // Parse JSON data
                let jsonWeather = jsonResult?["weather"] as! [AnyObject]
                
                for jsonCurrentWeather in jsonWeather {
                    weatherData.weather = jsonCurrentWeather["description"] as! String
                }
                
                let jsonMain = jsonResult?["main"] as! Dictionary<String, AnyObject>
                weatherData.temperature = jsonMain["temp"] as! Int
                
                completion(data: weatherData)

            } catch {
                print(error)
            }
        })
        
        task.resume()
    }

}

let _sharedWeatherService: WeatherService = { WeatherService() }()