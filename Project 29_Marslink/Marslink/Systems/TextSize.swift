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

public struct TextSize {
  
  fileprivate struct CacheEntry: Hashable {
    let text: String
    let font: UIFont
    let width: CGFloat
    let insets: UIEdgeInsets
    
    fileprivate var hashValue: Int {
      return text.hashValue ^ Int(width) ^ Int(insets.top) ^ Int(insets.left) ^ Int(insets.bottom) ^ Int(insets.right)
    }
  }
  
  fileprivate static var cache = [CacheEntry: CGRect]() {
    didSet {
      assert(Thread.isMainThread)
    }
  }
  
  public static func size(_ text: String, font: UIFont, width: CGFloat, insets: UIEdgeInsets = UIEdgeInsets.zero) -> CGRect {
    let key = CacheEntry(text: text, font: font, width: width, insets: insets)
    if let hit = cache[key] {
      return hit
    }
    
    let constrainedSize = CGSize(width: width - insets.left - insets.right, height: CGFloat.greatestFiniteMagnitude)
    let attributes = [ NSAttributedStringKey.font: font ]
    let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
    var bounds = (text as NSString).boundingRect(with: constrainedSize, options: options, attributes: attributes, context: nil)
    bounds.size.width = width
    bounds.size.height = ceil(bounds.height + insets.top + insets.bottom)
    cache[key] = bounds
    return bounds
  }
}

private func ==(lhs: TextSize.CacheEntry, rhs: TextSize.CacheEntry) -> Bool {
  return lhs.width == rhs.width && lhs.insets == rhs.insets && lhs.text == rhs.text
}
