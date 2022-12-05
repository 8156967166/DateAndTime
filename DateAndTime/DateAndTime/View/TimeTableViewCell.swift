//
//  TimeTableViewCell.swift
//  DateAndTime
//
//  Created by Bimal@AppStation on 04/11/22.
//

import UIKit

class TimeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelInTime: UILabel?
    @IBOutlet weak var labelTomorrowtime: UILabel?
    
    var cellModelInTime: TimeTableViewCellModel! {
        didSet {
            setTimeItems()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTimeItems() {
        
        labelInTime?.text = cellModelInTime.setTime()
        labelTomorrowtime?.text = cellModelInTime.setTime()
//        print("Time -----> \(String(describing: labelInTime?.text))")
//        print("Time TomorrowAnd nextDay -----> \(String(describing: labelTomorrowtime?.text))")
        
    }

}
