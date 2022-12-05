//
//  DateTableViewCellModel.swift
//  DateAndTime
//
//  Created by Bimal@AppStation on 03/11/22.
//
import UIKit
enum DateCellType {
    case dateCell
    case samplecell
}

class DateTableViewCellModel: NSObject {
    var identifier: String = "date.Cell"
    var cellType: DateCellType = .dateCell
//    var date = Date()
    var dateDetails:  Datess = Datess([:])
    
    init(strDate: String, cellType: DateCellType) {
        self.cellType = cellType
        self.dateDetails.date = strDate
        switch cellType {
        case .dateCell:
            identifier = "date.Cell"
        case .samplecell:
            identifier = "sample.Cell"
        }
    }
    
    func setDate() -> String {
        return dateDetails.date
    }
}
