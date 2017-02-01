//
//  WeatherService.swift
//  WeatherDemo
//
//  Created by Simon Ng on 12/1/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation

public class WeatherService {
    public typealias WeatherDataCompletionBlock = (data: WeatherData?) -> ()

    let openWeatherBaseAPI = "http://api.openweathermap.org/data/2.5/weather?appid=97cce5b42320d87100a885f5dfa0dac9&units=metric&q="
    let urlSession:NSURLSession = NSURLSession.sharedSession()

    public class func sharedWeatherService() -> WeatherService {
        return _sharedWeatherService
    }
    
    public func getCurrentWeather(location:String, completion: WeatherDataCompletionBlock) {
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