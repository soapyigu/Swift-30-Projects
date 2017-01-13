//
//  PhotoCommentViewController.swift
//  PhotoScroll
//
//  Copyright © 2017 raywenderlich. All rights reserved.
//

import UIKit

class PhotoCommentViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var nameTextField: UITextField!
  
  public var photoName: String!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let photoName = photoName {
      imageView.image = UIImage(named: photoName)
    }
    
    let tapGesture = UITapGestureRecognizer(target: self, action: Selector.generalTap)
    view.addGestureRecognizer(tapGesture)
    
    NotificationCenter.default.addObserver(
      self,
      selector: Selector.keyboardWillShowHandler,
      name: NSNotification.Name.UIKeyboardWillShow,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: Selector.keyboardWillHideHandler,
      name: NSNotification.Name.UIKeyboardWillHide,
      object: nil
    )
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  fileprivate func adjustInsetForKeyboard(isShow: Bool, notification: Notification) {
    guard let value = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {
      return
    }
    let keyboardFrame = value.cgRectValue
    let adjustmentHeight = (keyboardFrame.height + 20) * (isShow ? 1 : -1)
    scrollView.contentInset.bottom += adjustmentHeight
    scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
  
  func keyboardWillShow(notification: Notification) {
    adjustInsetForKeyboard(isShow: true, notification: notification)
  }
  
  func keyboardWillHide(notification: Notification) {
    adjustInsetForKeyboard(isShow: false, notification: notification)
  }
}

fileprivate extension Selector {
  static let keyboardWillShowHandler = #selector(PhotoCommentViewController.keyboardWillShow(notification:))
  static let keyboardWillHideHandler = #selector(PhotoCommentViewController.keyboardWillHide(notification:))
  static let generalTap = #selector(PhotoCommentViewController.dismissKeyboard)
}
