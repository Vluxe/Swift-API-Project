//
//  Guitar.swift
//  Client
//
//  Created by Dalton Cherry on 10/8/14.
//  Copyright (c) 2014 vluxe. All rights reserved.
//

import Foundation
import SwiftHTTP
import JSONJoy

class Guitar: JSONJoy {
    
    var id: Int
    var name: String
    var brand: String?
    var year: String?
    var price: String?
    var color: String?
    var imageUrl: String?
    
    required init(_ decoder: JSONDecoder) {
        id = decoder["id"].integer!
        name = decoder["name"].string!
        brand = decoder["brand"].string
        year = decoder["year"].string
        price = decoder["price"].string
        color = decoder["color"].string
        imageUrl = decoder["image_url"].string
    }
    ///public method to Get the index page by page
    class func all(page: Int, token: String,success:((Array<Guitar>) -> Void)!,failure:((NSError) -> Void)!) { //Array<Guitar>
        var task = API.newTask()
        task.GET("/guitars", parameters: ["auth_token": token], success: { (response: HTTPResponse) in
            if success != nil {
                if let resp = response.responseObject as? NSData {
                    var array = JSONDecoder(resp).array
                    var guitars = Array<Guitar>()
                    for decoder in array! {
                        guitars.append(Guitar(decoder))
                    }
                    success(guitars)
                }
            }
            }, { (error: NSError) in
                if failure != nil {
                    failure(error)
                }
        })
    }
}