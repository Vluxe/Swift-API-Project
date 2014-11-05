//
//  DetailViewController.swift
//  Client
//
//  Created by Dalton Cherry on 10/7/14.
//  Copyright (c) 2014 vluxe. All rights reserved.
//

import UIKit
import Skeets

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var detailItem: Guitar? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        if let guitar = detailItem {
            if let label = self.nameLabel {
                label.text = guitar.name
            }
            if let label = self.brandLabel {
                label.text = guitar.brand
            }
            if let label = self.yearLabel {
                label.text = guitar.year
            }
            if let label = self.colorLabel {
                label.text = guitar.color
            }
            if let label = self.priceLabel {
                label.text = "$\(guitar.price!)"
            }
            ImageManager.sharedManager.fetch(guitar.imageUrl!, progress: { (status: Double) in
            }, success: { (data: NSData) in
                if let iv = self.imageView {
                    iv.image = UIImage(data: data)
                }
            }, failure: { (error: NSError) in
                println("failed to get an image: \(error)")
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

