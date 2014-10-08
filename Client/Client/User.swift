//
//  User.swift
//  Client
//
//  Created by Dalton Cherry on 10/8/14.
//  Copyright (c) 2014 vluxe. All rights reserved.
//

import Foundation
import SwiftHTTP
import JSONJoy

public class User: JSONJoy {
    var id: Int
    var name: String
    var imageUrl: String?
    var authToken: String
    required public init(_ decoder: JSONDecoder) {
        id = decoder["id"].integer!
        name = decoder["name"].string!
        imageUrl = decoder["image_url"].string
        authToken = decoder["auth_token"].string!
    }
    
    //do a login request
    class func login(userName: String, password: String, success:((User) -> Void)!,failure:((NSError) -> Void)!) {
        var task = API.newTask()
        task.POST("/login", parameters: ["name": userName, "password": password], success: { (response: HTTPResponse) in
            if success != nil {
                if let resp = response.responseObject as? NSData {
                    success(User(JSONDecoder(resp)))
                }
            }
            }, { (error: NSError) in
                if failure != nil {
                    failure(error)
                }
        })
    }
    //create an account
    class func create(userName: String, password: String, imageUrl: String, success:((User) -> Void)!,failure:((NSError) -> Void)!) {
        var task = API.newTask()
        task.POST("/create", parameters: ["name": userName, "password": password,"imageUrl": imageUrl], success: { (response: HTTPResponse) in
            if success != nil {
                if let resp = response.responseObject as? NSData {
                    success(User(JSONDecoder(resp)))
                }
            }
            }, { (error: NSError) in
                if failure != nil {
                    failure(error)
                }
        })
    }
}
