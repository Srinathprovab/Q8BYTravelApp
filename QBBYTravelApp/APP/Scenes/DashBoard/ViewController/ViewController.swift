//
//  ViewController.swift
//  BeeoonsApp
//
//  Created by MA673 on 12/08/22.
//

import UIKit



//MARK: - INITIAL SETUP LABELS
func setuplabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont,align:NSTextAlignment) {
    lbl.text = text
    lbl.textColor = textcolor
    lbl.font = font
    lbl.numberOfLines = 0
    lbl.textAlignment = align
}

//MARK: - convert Date Format
func convertDateFormat(inputDate: String,f1:String,f2:String) -> String {
    
    let olDateFormatter = DateFormatter()
    olDateFormatter.dateFormat = f1
    
    guard let oldDate = olDateFormatter.date(from: inputDate) else { return "" }
    
    let convertDateFormatter = DateFormatter()
    convertDateFormatter.dateFormat = f2
    
    return convertDateFormatter.string(from: oldDate)
}


//MARK: - ccheckDepartureAndReturnDates1
func checkDepartureAndReturnDates1(_ parameters: [String: Any],p1:String) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    
    guard let departureDateStr = parameters[p1] as? String,
          let departureDate = dateFormatter.date(from: departureDateStr)
    else {
        return false
    }
    
    let calendar = Calendar.current
    let currentDate = Date()
    
    if calendar.isDateInTomorrow(departureDate) {
        return true
    } else if departureDate > currentDate {
        return true
    } else {
        return false
    }
    
    
}


//MARK: - ccheckDepartureAndReturnDates1
func checkDepartureAndReturnDates(_ parameters: [String: Any],p1:String,p2:String) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    
    guard let departureDateStr = parameters[p1] as? String,
          let returnDateStr = parameters[p2] as? String,
          let departureDate = dateFormatter.date(from: departureDateStr),
          let returnDate = dateFormatter.date(from: returnDateStr) else {
        print("Invalid date format")
        return false
    }
    
    let calendar = Calendar.current
    let currentDate = Date()
    
    if calendar.isDateInTomorrow(departureDate) {
        return true
    } else if departureDate > currentDate {
        return true
    } else {
        return false
    }
    
    if calendar.isDateInTomorrow(returnDate) {
        return true
    } else if returnDate > currentDate {
        return true
    } else {
        return false
    }
}




class ViewController: UIViewController {
    
    
    var ExecuteOnceBool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if !UserDefaults.standard.bool(forKey: "ExecuteOnceLoginVC") {
            ExecuteOnceBool = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                self.gotoLoginVC()
            })
            
            UserDefaults.standard.set(true, forKey: "ExecuteOnceLoginVC")
        }
        
        
        if ExecuteOnceBool == true {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                self.gotodashBoardScreen()
                
                
//                                                defaults.set("Flight", forKey: UserDefaultsKeys.tabselect)
//                                                self.gotogotoBookingConfirmedVC(urlstr: "https://www.q8by.com/mobile_webservices/index.php/voucher/flight/ALM-F-TP-1122-6017/PTBSID0000000016/BOOKING_CONFIRMED/show_voucher")
            })
        }
        
    }
    
    
    func gotodashBoardScreen() {
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    
    func gotoLoginVC() {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        vc.isvcFrom = "splashscreen"
        present(vc, animated: true)
    }
    
    func gotogotoBookingConfirmedVC(urlstr:String) {
        guard let vc = BookingConfirmedVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        vc.urlString = urlstr
        present(vc, animated: true)
    }
    
    
}

protocol TimerManagerDelegate: AnyObject {
    func timerDidFinish()
    func updateTimer()
}


class TimerManager {
    static let shared = TimerManager() // Singleton instance
    weak var delegate: TimerManagerDelegate?
    
    var timerDidFinish = false
    var timer: Timer?
    var totalTime = 1
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    private init() {}
    
    
    
    
    func startTimer(time:Int) {
        endBackgroundTask() // End any existing background task (if any)
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        
        // Reset the totalTime to its initial value (e.g., 60 seconds)
        totalTime = time
        
        // Schedule the timer in the common run loop mode
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    
    @objc func updateTimer() {
        if totalTime != 0 {
            totalTime -= 1
            delegate?.updateTimer()
        } else {
            sessionStop()
            delegate?.timerDidFinish()
            endBackgroundTask()
        }
    }
    
    @objc func sessionStop() {
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
        }
    }
    
    func stopTimer() {
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
        }
    }
    
    
    private func endBackgroundTask() {
        guard backgroundTask != .invalid else { return }
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
}

