//
//  API.swift
//  Client
//
//  Created by Dalton Cherry on 10/8/14.
//  Copyright (c) 2014 vluxe. All rights reserved.
//

import Foundation
import SwiftHTTP

struct API {
    ///pump new tasks off the lot
    static func newTask() -> HTTPTask {
        var apiManger = HTTPTask()
        apiManger.baseURL = "http://localhost:8080"
        return apiManger
        
    }
}