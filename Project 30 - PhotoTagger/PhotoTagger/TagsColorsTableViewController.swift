/*
* Copyright (c) 2015 Razeware LLC
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

struct TagsColorTableData {
  var label: String
  var color: UIColor?
}

class TagsColorsTableViewController: UITableViewController {

  // MARK: - Properties
  var data: [TagsColorTableData]?

  // MARK: - UITableViewDataSource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let data = data else {
      return 0
    }

    return data.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let data = data else {
      fatalError("Application error no cell data available")
    }
    
    let cellData = data[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "TagOrColorCell", for: indexPath)
    cell.textLabel?.text = cellData.label
    return cell
  }
  
  // MARK: - UITableViewDelegate
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let data = data else {
      fatalError("Application error no cell data available")
    }

    let cellData = data[indexPath.row]
    guard let color = cellData.color else {
      cell.textLabel?.textColor = UIColor.black
      cell.backgroundColor = UIColor.white
      return
    }
    
    var red = CGFloat(0.0), green = CGFloat(0.0), blue = CGFloat(0.0), alpha = CGFloat(0.0)
    color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    let threshold = CGFloat(105)
    let bgDelta = ((red * 0.299) + (green * 0.587) + (blue * 0.114));
    
    let textColor = (255 - bgDelta < threshold) ? UIColor.black : UIColor.white;
    cell.textLabel?.textColor = textColor
    cell.backgroundColor = color
  }
}
