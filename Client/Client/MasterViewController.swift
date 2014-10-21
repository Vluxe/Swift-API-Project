//
//  MasterViewController.swift
//  Client
//
//  Created by Dalton Cherry on 10/7/14.
//  Copyright (c) 2014 vluxe. All rights reserved.
//

import UIKit
import SwiftHTTP

class MasterViewController: UITableViewController, LoginDelegate {

    var detailViewController: DetailViewController? = nil
    var objects = Array<Guitar>()
    var user: User?


    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
}
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if user == nil {
            self.performSegueWithIdentifier("presentLogin", sender: self)
        }
    }
    
    //make a HTTP call to insert a new item into the DB
    func insertNewObject(sender: AnyObject) {
        //coming next week!
        
        //We post our newly created guitar, then add it to the UI.
//        apiManger.POST("/guitars", parameters: ["auth_token": ""], success: { (response: HTTPResponse) in
//            println("success")
//            }, { (error: NSError) in
//                println("got an error: \(error)")
//        })
//        //objects.insertObject(NSDate.date(), atIndex: 0)
        
        //let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        //self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row]
                let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        } else if segue.identifier == "presentLogin" {
            let vc = segue.destinationViewController as LoginViewController
            vc.delegate = self
        }
    }
    
    //MARK: - Login Delegate
    
    func didLogin(user: User) {
        self.user = user
        self.dismissViewControllerAnimated(true, completion: nil)
        Guitar.all(1, token: user.authToken, success: { (guitars: Array<Guitar>) in
            self.objects = guitars
            self.tableView.reloadData()
            }, { (error: NSError) in
                println("failed to load the guitars: \(error)")
        })
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let object = objects[indexPath.row]
        if let name = object.name {
         cell.textLabel.text = name
        }
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            objects.removeObjectAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
    }


}

