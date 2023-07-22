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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.gotodashBoardScreen()
        })
    }
    
    
    func gotodashBoardScreen() {
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    
}



class TimerManager {
    static let shared = TimerManager() // Singleton instance
    
    var timer: Timer?
    var totalTime = 1
   
    
    private init() {}
    
    func sessionStop() {
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        // Update the subtitle label in the last view controller
        if let lastViewController = UIApplication.shared.windows.first?.rootViewController?.presentedViewController as? PayNowVC {
           // lastViewController.subtitlelbl.text = timeFormatted(totalTime)
        }
        
        if totalTime != 0 {
            totalTime -= 1
            NotificationCenter.default.post(name: NSNotification.Name("updatetimer"), object: nil)
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
                sessionStop()
                gotoPopupScreen()
            }
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    func gotoPopupScreen(){
        NotificationCenter.default.post(name: NSNotification.Name("sessionStop"), object: nil)
    }
}
