//
//  LoginViewController.swift
//  Client
//
//  Created by Dalton Cherry on 10/8/14.
//  Copyright (c) 2014 vluxe. All rights reserved.
//

import UIKit

public protocol LoginDelegate {
    func didLogin(user: User)
}

public class LoginViewController : UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    public var delegate: LoginDelegate?
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //the login button action
    @IBAction func login(sender: UIButton) {
        loginButton.enabled = false
        createButton.enabled = false
        User.login(nameField.text, password: passwordField.text, success: { (user: User) in
            self.delegate?.didLogin(user)
            self.loginButton.enabled = true
            self.createButton.enabled = true
            }, { (error: NSError) in
                self.errorFinished(error)
        })
    }
    //the create button action
    @IBAction func create(sender: UIButton) {
        loginButton.enabled = false
        createButton.enabled = false
        User.create(nameField.text, password: passwordField.text, imageUrl: "someurl",
            success: { (user: User) in
            self.delegate?.didLogin(user)
            self.loginButton.enabled = true
            self.createButton.enabled = true
            }, { (error: NSError) in
                self.errorFinished(error)
        })
        
    }
    
    //show an alert and renable the buttons is the login or create failed
    func errorFinished(error: NSError) {
        println("unable to login")
        self.loginButton.enabled = true
        self.createButton.enabled = true
        let alert = UIAlertView(title: "Error", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "Ok")
        alert.show()
    }
    
}