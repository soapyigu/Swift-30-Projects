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

class WeatherSummaryCell: UICollectionViewCell {
  
  private let expandLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = UIColor.clear
    label.font = AppFont(size: 30)
    label.textColor = UIColor(hex6: 0x44758b)
    label.textAlignment = .center
    label.text = ">>"
    label.sizeToFit()
    return label
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.numberOfLines = 0
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.paragraphSpacing = 4
    let subtitleAttributes = [
      NSAttributedStringKey.font: AppFont(size: 14),
      NSAttributedStringKey.foregroundColor: UIColor(hex6: 0x42c84b),
      NSAttributedStringKey.paragraphStyle: paragraphStyle
    ]
    let titleAttributes = [
      NSAttributedStringKey.font: AppFont(size: 24),
      NSAttributedStringKey.foregroundColor: UIColor.white
    ]
    let attributedText = NSMutableAttributedString(string: "LATEST\n", attributes: subtitleAttributes)
    attributedText.append(NSAttributedString(string: "WEATHER", attributes: titleAttributes))
    label.attributedText = attributedText
    label.sizeToFit()
    
    return label
  }()
  

  func setExpanded(_ expanded: Bool) {
    self.expandLabel.transform = expanded ? CGAffineTransform(rotationAngle: CGFloat.pi / 2) : CGAffineTransform.identity
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(expandLabel)
    contentView.addSubview(titleLabel)
    contentView.backgroundColor = UIColor(hex6: 0x0c1f3f)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let insets = CommonInsets
    titleLabel.frame = CGRect(x: insets.left, y: 0, width: titleLabel.bounds.width, height: bounds.height)
    expandLabel.center = CGPoint(x: bounds.width - expandLabel.bounds.width/2 - insets.right, y: bounds.height/2)
  }
  
}
