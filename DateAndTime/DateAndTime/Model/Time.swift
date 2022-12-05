//
//  Time.swift
//  DateAndTime
//
//  Created by Bimal@AppStation on 04/11/22.
//

import Foundation


class Times {
    var time: String = ""
   
    
    init(_ dict: [String: Any]) {
        self.time = dict["time"] as? String ?? ""
    }
}

