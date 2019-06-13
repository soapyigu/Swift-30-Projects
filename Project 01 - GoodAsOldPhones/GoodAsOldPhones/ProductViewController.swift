//
//  ViewController.swift
//  GoodAsOldPhones
//
//  Copyright © 2016 Code School. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
  
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureView()
    }

    @IBAction func addToCartButtonDidTap(_ sender: AnyObject) {
        print("Add to cart successfully")
    }
    
    private func configureView() {
        productNameLabel.text = product?.name
        
        if let imageName = product?.fullScreenImageName {
            productImageView.image = UIImage(named: imageName)
        }
    }
}
