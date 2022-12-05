//
//  Date.swift
//  DateAndTime
//
//  Created by Bimal@AppStation on 03/11/22.
//


class Datess {
    var date: String = ""
   
    
    init(_ dict: [String: Any]) {
        self.date = dict["date"] as? String ?? ""
    }
}

