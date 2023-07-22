//
//  BookHotelVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//

import UIKit

class BookHotelVC: BaseTableVC {
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    var nationalityCode = String()
    var isVcFrom = String()
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    
    static var newInstance: BookHotelVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookHotelVC
        return vc
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
    }
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(nationalityCode(notification:)), name: NSNotification.Name("nationalityCode"), object: nil)
        
    }
    
    @objc func nationalityCode(notification: NSNotification){
        nationalityCode = notification.object as? String ?? ""
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        
        self.view.backgroundColor = .WhiteColor
        self.holderView.backgroundColor = .WhiteColor
        nav.contentView.backgroundColor = .WhiteColor
        nav.navtitle.isHidden = false
        nav.titlelbl.isHidden = true
        setuplabels(lbl:  nav.navtitle, text: "Book Hotel", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 20), align: .center)
        nav.backBtn.addTarget(self, action: #selector(backbtnAction(_:)), for: .touchUpInside)
        let screenHeight = UIScreen.main.bounds.size.height
        
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "SearchFlightTVCell",
                                         "DashboardDealsTitleTVCell",
                                         "HotelDealsTVCell"])
        
        
        if isVcFrom == "modify" {
            self.holderView.backgroundColor = .clear
            commonTableView.isScrollEnabled = false
            appendModifyHotelSearctTvcells(str: "hotel")
        }else {
            self.holderView.backgroundColor = .WhiteColor
            appendHotelSearctTvcells(str: "hotel")
        }
        
    }
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    func appendHotelSearctTvcells(str:String) {
        tablerow.removeAll()
        
        tablerow.append(TableRow(key:"hotel",cellType:.SearchFlightTVCell))
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"BEST HOTELS",key: "deals", text:imgPath, height:50,cellType:.DashboardDealsTitleTVCell))
        tablerow.append(TableRow(title:imgPath,key:"hotel",cellType:.HotelDealsTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    func appendModifyHotelSearctTvcells(str:String) {
        tablerow.removeAll()
        tablerow.append(TableRow(key:str,cellType:.SearchFlightTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    @objc func backbtnAction(_ sender:UIButton) {
        callapibool = true
        if isVcFrom == "modify"{
            dismiss(animated: true)
        }else {
            guard let vc = DBTabbarController.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            vc.selectedIndex = 0
            self.present(vc, animated: false)
        }
    }
    
    override func didTapOnLocationOrCityBtn(cell:HolderViewTVCell){
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = "Location/ City"
        vc.keyStr = "hotel"
        self.present(vc, animated: false)
    }
    
    
    override func didtapOnCheckInBtn(cell:DualViewTVCell){
        guard let vc = Calvc.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
    override func didtapOnCheckOutBtn(cell:DualViewTVCell){
        guard let vc = Calvc.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    override func didTapOnAddTravelerEconomy(cell:HolderViewTVCell){
        guard let vc = AddRoomsVCViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    override func didTapOnAddRooms(cell:HolderViewTVCell){
        guard let vc = AddRoomsVCViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
    
    override func didTapOnSearchHotelsBtn(cell:ButtonTVCell){
        
        payload["city"] = defaults.string(forKey: UserDefaultsKeys.locationcity)
        payload["hotel_destination"] = defaults.string(forKey: UserDefaultsKeys.locationid)
        payload["hotel_checkin"] = defaults.string(forKey: UserDefaultsKeys.checkin)
        payload["hotel_checkout"] = defaults.string(forKey: UserDefaultsKeys.checkout)
        payload["rooms"] = defaults.string(forKey: UserDefaultsKeys.roomcount)
        payload["adult"] = adtArray
        payload["child"] = chArray
        payload["childAge_1"] = ["0","0"]
        payload["nationality"] = nationalityCode
        
        
        do {
            
            let arrJson = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            let theJSONText = NSString(data: arrJson, encoding: String.Encoding.utf8.rawValue) ?? ""
            payload1["search_params"] = theJSONText
            
        }catch let error as NSError{
            print(error.description)
        }
        
        
        
        if defaults.string(forKey: UserDefaultsKeys.locationcity) == "city/location" || defaults.string(forKey: UserDefaultsKeys.locationcity) == nil {
            showToast(message: "Enter Hotel or City ")
        }else if defaults.string(forKey: UserDefaultsKeys.checkin) == "Check In" || defaults.string(forKey: UserDefaultsKeys.checkin) == nil{
            showToast(message: "Enter Checkin Date")
        }else if defaults.string(forKey: UserDefaultsKeys.checkout) == "Check Out" || defaults.string(forKey: UserDefaultsKeys.checkout) == nil{
            showToast(message: "Enter Checkout Date")
        }else if defaults.string(forKey: UserDefaultsKeys.checkout) == defaults.string(forKey: UserDefaultsKeys.checkin) {
            showToast(message: "Enter Different Dates")
        }else if defaults.string(forKey: UserDefaultsKeys.roomcount) == "" {
            showToast(message: "Add Rooms For Booking")
        }else if self.nationalityCode.isEmpty == true {
            showToast(message: "Please Select Nationality.")
        }else if checkDepartureAndReturnDates(payload, p1: "hotel_checkin", p2: "hotel_checkout") == false {
            showToast(message: "Invalid Date")
        }else {
            guard let vc = HotelSearchResultVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            vc.payload = self.payload1
            callapibool = true
            self.present(vc, animated: false)
        }
        
    }
    
}
