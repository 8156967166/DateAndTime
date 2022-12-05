//
//  TimeTableViewCellModel.swift
//  DateAndTime
//
//  Created by Bimal@AppStation on 04/11/22.
//

import Foundation

enum TimeCellType {
    case timeCell
    case tomorrowTimeCell
}

class TimeTableViewCellModel: NSObject {
    var identifier: String = "time.Cell"
    var cellType: TimeCellType = .timeCell
//    var date = Date()
    var timeDetails:  Times = Times([:])
    
    init(strTime: String, cellType: TimeCellType) {
        self.cellType = cellType
        self.timeDetails.time = strTime
        switch cellType {
        case .timeCell:
            identifier = "time.Cell"
        case .tomorrowTimeCell:
            identifier = "tomorrowTime.Cell"
        }
    }
    
    func setTime() -> String {
        return timeDetails.time
    }
}
