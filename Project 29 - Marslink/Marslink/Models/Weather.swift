/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

enum WeatherCondition: String {
  case cloudy = "Cloudy"
  case sunny = "Sunny"
  case partlyCloudy = "Partly Cloudy"
  case dustStorm = "Dust Storm"
  
  var emoji: String {
    switch self {
    case .cloudy: return "☁️"
    case .sunny: return "☀️"
    case .partlyCloudy: return "⛅️"
    case .dustStorm: return "🌪"
    }
  }
}

class Weather: NSObject {
  
  let temperature: Int
  let high: Int
  let low: Int
  let date: Date
  let sunrise: String
  let sunset: String
  let condition: WeatherCondition
  
  init(
    temperature: Int,
    high: Int,
    low: Int,
    date: Date,
    sunrise: String,
    sunset: String,
    condition: WeatherCondition
    ) {
    self.temperature = temperature
    self.high = high
    self.low = low
    self.date = date
    self.sunrise = sunrise
    self.sunset = sunset
    self.condition = condition
  }
  
}
