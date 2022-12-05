//
//  DateTableViewCell.swift
//  DateAndTime
//
//  Created by Bimal@AppStation on 03/11/22.
//

import UIKit

class DateTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDate: UILabel!
    

    var cellModel: DateTableViewCellModel! {
        didSet {
            setDateItems()
            
            let date = Date()
            let todayFormatter = DateFormatter()
            todayFormatter.dateFormat = "yyyy-MM-dd"
            let todayString = todayFormatter.string(from: date)
            
            if labelDate.text == todayString {
                labelDate.text = "Today"
            }
            
            let tommorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
                
//                print("Tomorrow Date ----> \(tommorrow!)")
                let tommorrowFormatter = DateFormatter()
                tommorrowFormatter.dateFormat = "yyyy-MM-dd"
                let tommorrowString = tommorrowFormatter.string(from: tommorrow!)
//                print("tomorrowString ---> \(tommorrowString)")
            if labelDate.text == tommorrowString {
                labelDate.text = "Tomorrow"
            }
            
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
    
    func setDateItems() {
        labelDate.text = cellModel.setDate()
        print("Dates  -------> \(labelDate.text!)")
    }
}
