//
//  MyBookingVC.swift
//  KuwaitWays
//
//  Created by FCI on 08/05/23.
//

import UIKit

class MyBookingVC: BaseTableVC {
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var btnsView: UIView!
    @IBOutlet weak var upcomingBtnView: UIView!
    @IBOutlet weak var upcomingul: UIView!
    @IBOutlet weak var upcominglbl: UILabel!
    @IBOutlet weak var upcomingBtn: UIButton!
    @IBOutlet weak var completedBtnView: UIView!
    @IBOutlet weak var completedul: UIView!
    @IBOutlet weak var completedlbl: UILabel!
    @IBOutlet weak var completedBtn: UIButton!
    @IBOutlet weak var cancelledBtnView: UIView!
    @IBOutlet weak var cancelledul: UIView!
    @IBOutlet weak var cancelledlbl: UILabel!
    @IBOutlet weak var cancelledBtn: UIButton!
    
    var payload = [String:Any]()
    var tablerow = [TableRow]()
    var vm:MyBookingViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        let logstatus = defaults.bool(forKey: UserDefaultsKeys.userLoggedIn)
        if logstatus == true {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            callUpcommingBookingsAPI()
            btnsView.isUserInteractionEnabled = true
            btnsView.alpha = 1
            //            btnsView.isHidden = false
        }else {
            setupTableViewWenNoLogin()
            btnsView.isUserInteractionEnabled = false
            btnsView.alpha = 0.3
            //            btnsView.isHidden = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = MyBookingViewModel(self)
    }
    
    
    func setupUI() {
        self.view.backgroundColor = .WhiteColor
        nav.backgroundColor = .AppBackgroundColor
        nav.titlelbl.text = "My Bookings"
        nav.backBtn.isHidden = true
        
        upcomingBtn.setTitle("", for: .normal)
        upcomingBtn.tag = 1
        upcomingBtn.addTarget(self, action: #selector(didtapOnButtoninMyBookingsScreen(_:)), for: .touchUpInside)
        
        completedBtn.setTitle("", for: .normal)
        completedBtn.tag = 2
        completedBtn.addTarget(self, action: #selector(didtapOnButtoninMyBookingsScreen(_:)), for: .touchUpInside)
        
        cancelledBtn.setTitle("", for: .normal)
        cancelledBtn.tag = 3
        cancelledBtn.addTarget(self, action: #selector(didtapOnButtoninMyBookingsScreen(_:)), for: .touchUpInside)
        
        
        setuplabels(lbl: upcominglbl, text: "Upcoming", textcolor: .AppBackgroundColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: completedlbl, text: "Completed", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: cancelledlbl, text: "Cancelled", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 14), align: .center)
        
        upcomingul.backgroundColor = .AppBackgroundColor
        completedul.backgroundColor = .WhiteColor
        cancelledul.backgroundColor = .WhiteColor
        
        commonTableView.backgroundColor = .AppHolderViewColor
        commonTableView.registerTVCells(["MyBookingsTVCells"])
        
    }
    
    
    @objc func didtapOnButtoninMyBookingsScreen(_ sender:UIButton){
        switch sender.tag {
            
        case 1:
            didTaponUpcommingBtnAction()
            break
            
        case 2:
            didTapOnCompletedBtnAction()
            break
            
        case 3:
            didTapOnCancelledBtnAction()
            break
            
        default:
            break
        }
        
    }
    
    
    func didTaponUpcommingBtnAction() {
        upcomingul.backgroundColor = .AppBackgroundColor
        completedul.backgroundColor = .WhiteColor
        cancelledul.backgroundColor = .WhiteColor
        setuplabels(lbl: upcominglbl, text: "Upcoming", textcolor: .AppBackgroundColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: completedlbl, text: "Completed", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: cancelledlbl, text: "Cancelled", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 14), align: .center)
        
        callUpcommingBookingsAPI()
    }
    
    func didTapOnCompletedBtnAction() {
        completedul.backgroundColor = .AppBackgroundColor
        upcomingul.backgroundColor = .WhiteColor
        cancelledul.backgroundColor = .WhiteColor
        
        setuplabels(lbl: upcominglbl, text: "Upcoming", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: completedlbl, text: "Completed", textcolor: .AppBackgroundColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: cancelledlbl, text: "Cancelled", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 14), align: .center)
        
        callCompletedBookingsAPI()
    }
    
    func didTapOnCancelledBtnAction() {
        cancelledul.backgroundColor = .AppBackgroundColor
        completedul.backgroundColor = .WhiteColor
        upcomingul.backgroundColor = .WhiteColor
        
        setuplabels(lbl: upcominglbl, text: "Upcoming", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: completedlbl, text: "Completed", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: cancelledlbl, text: "Cancelled", textcolor: .AppBackgroundColor, font: .LatoRegular(size: 14), align: .center)
        
        callCancelledBookingsAPI()
    }
    
    
    
    
    func callUpcommingBookingsAPI() {
        payload["user_id"] = "2076"
        vm?.CALL_UPCOMMING_BOOKINGS_API(dictParam: payload)
    }
    
    
    func callCompletedBookingsAPI() {
        payload["user_id"] = "2076"
        vm?.CALL_COMPLETED_BOOKINGS_API(dictParam: payload)
    }
    
    func callCancelledBookingsAPI() {
        payload["user_id"] = "2076"
        vm?.CALL_CANCELLED_BOOKINGS_API(dictParam: payload)
    }
    
}


extension MyBookingVC:MyBookingViewModelDelegate {
    func upcommingbookingsdetails(response: MyBookingModel) {
        print(" ===== upcommingbookingsdetails ====")
        DispatchQueue.main.async {
            self.setupTVCells(flightdata: response.flight_data ?? [], key1: "up")
        }
    }
    
    func completedbookingsdetails(response: MyBookingModel) {
        print(" ===== completedbookingsdetails ====")
        DispatchQueue.main.async {
            self.setupTVCells(flightdata: response.flight_data ?? [], key1: "completed")
            
        }
    }
    
    func cancelledbookingsdetails(response: MyBookingModel) {
        print(" ===== cancelledbookingsdetails ====")
        DispatchQueue.main.async {
            self.setupTVCells(flightdata: response.flight_data ?? [], key1: "cancel")
        }
    }
    
    
    func setupTVCells(flightdata:[MyBookingsFlightData],key1:String) {
        tablerow.removeAll()
        
        flightdata.forEach { i in
            i.summary?.forEach({ k in
                tablerow.append(TableRow(title:"j.access_key",
                                         fromTime: k.origin?.time,
                                         toTime:k.destination?.time,
                                         fromCity: k.origin?.city,
                                         toCity: k.destination?.city,
                                         fromdate: k.origin?.date,
                                         todate: k.destination?.date,
                                         noosStops: "\(k.no_of_stops ?? 0) Stops",
                                         airlineslogo: k.operator_image,
                                         airlinesCode:"(\(k.operator_code ?? "")-\(k.operator_name ?? ""))",
                                         kwdprice:"\(flightdata.first?.transaction?.currency ?? ""):\(flightdata.first?.transaction?.fare ?? "")",
                                         travelTime: k.duration,
                                         key: key1,
                                         cellType:.MyBookingsTVCells))
                
            })
        }
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
        if flightdata.count == 0 {
            tablerow.removeAll()
            
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
        
    }
    
    
    
    func setupTableViewWenNoLogin() {
        tablerow.removeAll()
        TableViewHelper.EmptyMessage(message: "Login To View Your Bookings", tableview: commonTableView, vc: self)
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
}
