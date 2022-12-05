//
//  DateandTimeViewController.swift
//  DateAndTime
//
//  Created by Bimal@AppStation on 08/11/22.

import UIKit

class DateandTimeViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var tableViewDate: UITableView!
    @IBOutlet weak var tableViewTime: UITableView!
    @IBOutlet weak var viewOuterTableView: UIView!
    @IBOutlet weak var viewTopGradient: UIView!
    @IBOutlet weak var viewBottomGradient: UIView!
    
    // MARK: - Variable
    
    var dateArrayViewModel: [DateTableViewCellModel] = []
    var timeArrayViewModel: [TimeTableViewCellModel] = []
    var isScrolling = Bool()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         1.  Calculate Dates
         2.  Calculate Times
         */
        
        createCellModelDate()
        loadTimeForToday()
//        loadTimeForOther()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableViewDate.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
        self.tableViewTime.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
        setGradient()
    }
    
    // MARK: - Func
   
    func setGradient() {
        let gradient = CAGradientLayer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            gradient.frame = self.viewTopGradient.superview?.bounds ?? .null
        }
    
        gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.0, 0.10, 0.25, 0.75, 0.95, 1.0]
        viewTopGradient.superview?.layer.mask = gradient
//        tableViewDate.backgroundColor = .clear
    }


    
    func createCellModelDate() {
        
        let currentDate = Date()
        var arrayDates: [Date] = []
        
        arrayDates.append(currentDate)
        
        for i in 1 ... 29 {
            if let newDate = Calendar.current.date(byAdding: .day, value: i, to: currentDate) {
                arrayDates.append(newDate)
            }
        }
        
        dateArrayViewModel.removeAll()
        for date in arrayDates {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let vm = DateTableViewCellModel(strDate: "\(formatter.string(from: date))", cellType: .dateCell)
            dateArrayViewModel.append(vm)
        }
       
        DispatchQueue.main.async {
            self.tableViewDate.reloadData()
        }
    }
    
    func findFinalCellAndLoadData() {
        
        if let indexPath = tableViewDate.indexPathForRow(at: CGPoint(x: tableViewDate.bounds.midX , y: tableViewDate.bounds.midY)) {
            debugPrint(indexPath)
            tableViewDate.scrollToRow(at: indexPath,
                                      at: .middle, animated: true)
            let cell = tableViewDate.cellForRow(at: indexPath) as! DateTableViewCell
            print("cell labelDate ---- \(cell.labelDate.text!)")
//            cell.labelDate.textColor = .black
            loadData(for: indexPath)
            
        }
        
        if let indexPath = tableViewTime.indexPathForRow(at: CGPoint(x: tableViewTime.bounds.midX, y: tableViewTime.bounds.midY)) {
            debugPrint(indexPath)
            tableViewTime.scrollToRow(at: indexPath,
                                      at: .middle, animated: true)
        }
    }

    func loadData(for indexPath: IndexPath) {
        
//       let cell = tableViewDate.cellForRow(at: indexPath) as! DateTableViewCell
        let cellModel = dateArrayViewModel[indexPath.row]
        let date = Date()
        let todayFormatter = DateFormatter()
        todayFormatter.dateFormat = "yyyy-MM-dd"
        let todayString = todayFormatter.string(from: date)

        if cellModel.dateDetails.date == todayString {
            // today code
            loadTimeForToday()
            
        }
        else {
            // other code
            
            loadTimeForOther()
            
        }
        
        DispatchQueue.main.async {
            self.tableViewTime.reloadData()
        }
    }
    
    func loadTimeForToday() {
        // Load times for today
        
        let currentDate = Date()
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        let nextDate12 = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: nextDate)!
        let hour = Calendar.current.component(.hour, from: currentDate)
        let minutes = Calendar.current.component(.minute, from: currentDate)
        
        var startingDate: Date
        
        switch minutes {
        case 0 ... 15:
            startingDate = Calendar.current.date(bySettingHour: hour,
                                                 minute: 15,
                                                 second: 0,
                                                 of: currentDate)!
        case 16 ... 30:
            startingDate = Calendar.current.date(bySettingHour: hour,
                                                 minute: 30,
                                                 second: 0,
                                                 of: currentDate)!
        case 31 ... 45:
            startingDate = Calendar.current.date(bySettingHour: hour,
                                                 minute: 45,
                                                 second: 0,
                                                 of: currentDate)!
        default:
            startingDate = Calendar.current.date(bySettingHour: hour + 1,
                                                 minute: 0,
                                                 second: 0,
                                                 of: currentDate)!
        }
        
        
        timeArrayViewModel.removeAll()
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "hh:mm a"
//        let endDate = "\(tommorrowDateString) 12:00 AM"
//        let date2 = formatter.date(from: endDate)
        
        while startingDate < nextDate12 {
            let time = formatter2.string(from: startingDate)
            let vm = TimeTableViewCellModel(strTime: time, cellType: .timeCell)
            timeArrayViewModel.append(vm)
            startingDate = Calendar.current.date(byAdding: .minute, value: 15, to: startingDate)!
        }
    }
    
    func loadTimeForOther() {
        // load times for other day
        
        
        var startingDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: startingDate)!
        let nextDate12 = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: nextDate)!
        
        timeArrayViewModel.removeAll()
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "hh:mm a"
        
        while startingDate < nextDate12 {
            let time = formatter2.string(from: startingDate)
            let vm = TimeTableViewCellModel(strTime: time, cellType: .timeCell)
            timeArrayViewModel.append(vm)
            startingDate = Calendar.current.date(byAdding: .minute, value: 15, to: startingDate)!
        }
    }
    
    @IBAction func buttonActionDone(sender: UIButton) {
        
        var indexPathDate = IndexPath()
        var indexPathTime = IndexPath()
        
        if let indexPath = tableViewDate.indexPathForRow(at: CGPoint(x: tableViewDate.bounds.midX , y: tableViewDate.bounds.midY)) {
            debugPrint(indexPath)
            tableViewDate.scrollToRow(at: indexPath,
                                      at: .middle, animated: true)
            indexPathDate = indexPath
        }
        
        if let indexPath = tableViewTime.indexPathForRow(at: CGPoint(x: tableViewTime.bounds.midX , y: tableViewTime.bounds.midY)) {
            debugPrint(indexPath)
            tableViewTime.scrollToRow(at: indexPath,
                                      at: .middle, animated: true)
            indexPathTime = indexPath
        }
        let cellModelDate = dateArrayViewModel[indexPathDate.row]
        let cellModelTime = timeArrayViewModel[indexPathTime.row]
        print("Selected Date and Time : \(cellModelDate.dateDetails.date), \(cellModelTime.timeDetails.time)")
        
    }
}

// MARK: - UIScrollViewDelegate

extension DateandTimeViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        if decelerate {
            debugPrint("111")
            debugPrint(#function)
        } else {
            debugPrint("222")
            debugPrint(#function)
            // Final
//
            findFinalCellAndLoadData()
            if scrollView == tableViewDate {
                scrollToTop()
            }

        }
    }


    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        debugPrint(#function)
        // Final

        findFinalCellAndLoadData()

        if scrollView == tableViewDate {
            scrollToTop()
        }

    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        findFinalCellAndLoadData()
//        if scrollView == tableViewDate {
//            scrollToTop()
//        }
//    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {

        print("scrollViewDidScrollToTop")
        
    }
    
    func scrollToTop() {
        let topRow = IndexPath(row: 0, section: 0)
        
        self.tableViewTime.scrollToRow(at: topRow,
                                       at: .top,
                                       animated: true)
    }
    

}

// MARK: - TableView

extension DateandTimeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewDate {
            return dateArrayViewModel.count
        }
        else {
            return timeArrayViewModel.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        print("index ----> \(index)")
        
        if tableView == tableViewTime {
            
            let cellModelTime = timeArrayViewModel[indexPath.row]
            let cellInTime = tableView.dequeueReusableCell(withIdentifier: cellModelTime.identifier,  for: indexPath) as? TimeTableViewCell
            
            cellInTime?.cellModelInTime = cellModelTime
            return cellInTime!
            
        } else if tableView == tableViewDate {
            let cellModel = dateArrayViewModel[indexPath.row]
            let cellInDate = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath) as? DateTableViewCell
            cellInDate?.cellModel = cellModel
            return cellInDate!
        }
    
        return UITableViewCell()
    }
}







