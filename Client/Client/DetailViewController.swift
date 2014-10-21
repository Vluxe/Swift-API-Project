//
//  DetailViewController.swift
//  Client
//
//  Created by Dalton Cherry on 10/7/14.
//  Copyright (c) 2014 vluxe. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailDescriptionLabel: UILabel!

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
            if let label = self.detailDescriptionLabel {
                label.text = guitar.name
            }
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

