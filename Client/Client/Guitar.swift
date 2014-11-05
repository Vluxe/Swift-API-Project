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
    var name: String?
    var brand: String?
    var year: String?
    var price: Int?
    var color: String?
    var imageUrl: String?
    
    //stand init method
    init(name: String, brand: String, year: String, price: Int, color: String, imageUrl: String) {
        self.id = 0
        self.name = name
        self.brand = brand
        self.price = price
        self.color = color
        self.year = year
        self.imageUrl = imageUrl
    }
    //decoder method
    required init(_ decoder: JSONDecoder) {
        id = decoder["id"].integer!
        name = decoder["name"].string
        brand = decoder["brand"].string
        year = decoder["year"].string
        price = decoder["price"].integer
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
                    if let arr = array {
                        for decoder in arr {
                            guitars.append(Guitar(decoder))
                        }
                    }
                    success(guitars)
                }
            }
            }, { (error: NSError, response: HTTPResponse?) in
                if failure != nil {
                    failure(error)
                }
        })
    }
}