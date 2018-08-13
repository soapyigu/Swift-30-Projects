//
//  ViewController.swift
//  WebviewStudy
//
//  Created by Yi Gu on 8/6/18.
//  Copyright © 2018 Yi Gu. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var webView: WKWebView!
  @IBOutlet weak var progressBar: UIProgressView!
  @IBOutlet weak var barView: UIView!
  @IBOutlet weak var urlField: UITextField!
  @IBOutlet weak var backButton: UIBarButtonItem!
  @IBOutlet weak var forwardButton: UIBarButtonItem!
  @IBOutlet weak var reloadButton: UIBarButtonItem!
  
  // MARK: - Parameters
  var urlStr: String = "https://www.apple.com"
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    urlField.delegate = self
    
    backButton.isEnabled = false
    forwardButton.isEnabled = false
    
    webView.navigationDelegate = self
    webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    webView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
    webView.load(urlStr)
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "loading" {
      backButton.isEnabled = webView.canGoBack
      forwardButton.isEnabled = webView.canGoForward
    } else if keyPath == "estimatedProgress" {
      progressBar.isHidden = webView.estimatedProgress == 1
      progressBar.setProgress(Float(webView.estimatedProgress), animated: true)
    }
  }
  
  // MARK: - Actions
  @IBAction func back(_ sender: Any) {
    webView.goBack()
  }
  
  @IBAction func forward(_ sender: Any) {
    webView.goForward()
  }
  
  @IBAction func reload(_ sender: Any) {
    webView.reload()
  }
}

// MARK: - WKNavigationDelegate
extension ViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    
    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    
    urlField.text = webView.url?.absoluteString
    
    progressBar.setProgress(0.0, animated: false)
  }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    urlField.resignFirstResponder()
    if let str = textField.text {
      urlStr = "https://" + str
      webView.load(urlStr)
    }
    
    return false
  }
}

// MARK: - WKWebView Extension
extension WKWebView {
  func load(_ urlString: String) {
    
    if let url = URL(string: urlString) {
      let request = URLRequest(url: url)
      load(request)
    }
  }
}
