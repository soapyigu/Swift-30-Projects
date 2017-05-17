/*
 * Copyright (c) 2014 Razeware LLC
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

class HTTPClient {
  
  func getRequest(_ url: String) -> (AnyObject) {
    return Data() as (AnyObject)
  }
  
  func postRequest(_ url: String, body: String) -> (AnyObject){
    return Data() as (AnyObject)
  }
  
  // This is synchronous way to download image via url, please use it in background
  func downloadImage(_ url: String) -> (UIImage) {
    let aUrl = URL(string: url)
    
    guard let data = try? Data(contentsOf: aUrl!) else {
      return UIImage()
    }
    
    let image = UIImage(data: data)
    return image!
  }
  
}
