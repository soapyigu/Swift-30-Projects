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

// go to https://www.flickr.com/services/api/explore/flickr.photos.search to get the latest apikey
let apiKey = "68235aae25e7a935db219ebce37f5735"

class Flickr {
  
  let processingQueue = OperationQueue()
  
  func searchFlickrForTerm(_ searchTerm: String, completion : @escaping (_ results: FlickrSearchResults?, _ error : NSError?) -> Void){
    
    guard let searchURL = flickrSearchURLForSearchTerm(searchTerm) else {
      let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
      completion(nil, APIError)
      return
    }
    
    let searchRequest = URLRequest(url: searchURL)
    
    URLSession.shared.dataTask(with: searchRequest, completionHandler: { (data, response, error) in
      
      if let _ = error {
        let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
        OperationQueue.main.addOperation({
          completion(nil, APIError)
        })
        return
      }
      
      guard let _ = response as? HTTPURLResponse,
        let data = data else {
          let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
          OperationQueue.main.addOperation({
            completion(nil, APIError)
          })
          return
      }
      
      do {
        
        guard let resultsDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject],
        let stat = resultsDictionary["stat"] as? String else {
          
          let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
          OperationQueue.main.addOperation({
            completion(nil, APIError)
          })
          return
        }
        
        switch (stat) {
        case "ok":
          print("Results processed OK")
        case "fail":
          if let message = resultsDictionary["message"] {
            
            let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:message])
            
            OperationQueue.main.addOperation({
              completion(nil, APIError)
            })
          }
          
          let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: nil)
          
          OperationQueue.main.addOperation({
            completion(nil, APIError)
          })
  
          return
        default:
          let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
          OperationQueue.main.addOperation({
            completion(nil, APIError)
          })
          return
        }
        
        guard let photosContainer = resultsDictionary["photos"] as? [String: AnyObject], let photosReceived = photosContainer["photo"] as? [[String: AnyObject]] else {
          
          let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
          OperationQueue.main.addOperation({
            completion(nil, APIError)
          })
          return
        }
        
        var flickrPhotos = [FlickrPhoto]()
        
        for photoObject in photosReceived {
          guard let photoID = photoObject["id"] as? String,
            let farm = photoObject["farm"] as? Int ,
            let server = photoObject["server"] as? String ,
            let secret = photoObject["secret"] as? String else {
              break
          }
          let flickrPhoto = FlickrPhoto(photoID: photoID, farm: farm, server: server, secret: secret)
          
          guard let url = flickrPhoto.flickrImageURL(),
            let imageData = try? Data(contentsOf: url as URL) else {
              break
          }
          
          if let image = UIImage(data: imageData) {
            flickrPhoto.thumbnail = image
            flickrPhotos.append(flickrPhoto)
          }
        }
              
        OperationQueue.main.addOperation({
          completion(FlickrSearchResults(searchTerm: searchTerm, searchResults: flickrPhotos), nil)
        })
        
      } catch _ {
        completion(nil, nil)
        return
      }
      
      
      }) .resume()
  }
  
  fileprivate func flickrSearchURLForSearchTerm(_ searchTerm:String) -> URL? {
    
    guard let escapedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else {
      return nil
    }
    
    let URLString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(escapedTerm)&per_page=20&format=json&nojsoncallback=1"
    
    guard let url = URL(string:URLString) else {
      return nil
    }
    
    return url
  }
}
