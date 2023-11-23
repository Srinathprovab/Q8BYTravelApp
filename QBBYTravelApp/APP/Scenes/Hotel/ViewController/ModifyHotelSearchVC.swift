//
//  ModifyHotelSearchVC.swift
//  QBBYTravelApp
//
//  Created by FCI on 23/11/23.
//

import UIKit

class ModifyHotelSearchVC: BaseTableVC {

    @IBOutlet weak var holderView: UIView!
    
    var nationalityCode = String()
    var isVcFrom = String()
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    static var newInstance: ModifyHotelSearchVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifyHotelSearchVC
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
        setInitalValues()
    }
    
    func setupUI() {
        
        self.view.backgroundColor = .WhiteColor
        self.holderView.backgroundColor = .WhiteColor
        
        commonTableView.isScrollEnabled = false
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "BookHotelTVCell",
                                         "DashboardDealsTitleTVCell",
                                         "HotelDealsTVCell"])
        
        
        appendHotelSearctTvcells(str: "hotel")
        
    }
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    func appendHotelSearctTvcells(str:String) {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Modify",key:"hotel",cellType:.BookHotelTVCell))
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    

    
    func setInitalValues() {
        
        adtArray.removeAll()
        chArray.removeAll()
        
        adtArray.append("2")
        chArray.append("0")
        
        defaults.set("1", forKey: UserDefaultsKeys.roomcount)
        defaults.set("2", forKey: UserDefaultsKeys.hoteladultscount)
        defaults.set("0", forKey: UserDefaultsKeys.hotelchildcount)
        
        defaults.set("Rooms \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? ""),Adults \(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "")", forKey: UserDefaultsKeys.selectPersons)
        
    }
    
    
    //MARK: - BookHotelTVCell Delegate Functions
    override func didTapOnHotelBackBtnAction(cell: BookHotelTVCell) {
        callapibool = true
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        self.present(vc, animated: false)
    }
    override func didTapOnSelectCityBtnAction(cell: BookHotelTVCell) {
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = "Location/ City"
        vc.keyStr = "hotel"
        self.present(vc, animated: false)
    }
    override func didTapOnCheckInBtnAction(cell: BookHotelTVCell) {
        guard let vc = Calvc.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    override func didTapOnCheckOutBtnAction(cell: BookHotelTVCell) {
        guard let vc = Calvc.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    override func didTapOnSelectTravellerAndEconomyBtnAction(cell: BookHotelTVCell) {
        guard let vc = AddRoomsVCViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    override func didTaponSelectNationalityBtnAction(cell: BookHotelTVCell) {
        guard let vc = NationalityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    
    override func didTapOnHotelSearchBtnAction(cell:BookHotelTVCell) {
        
        payload.removeAll()
        payload["city"] = defaults.string(forKey: UserDefaultsKeys.locationcity)
        payload["hotel_destination"] = defaults.string(forKey: UserDefaultsKeys.locationid)
        payload["hotel_checkin"] = defaults.string(forKey: UserDefaultsKeys.checkin)
        payload["hotel_checkout"] = defaults.string(forKey: UserDefaultsKeys.checkout)
        
        payload["rooms"] = "\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "1")"
        payload["adult"] = adtArray
        payload["child"] = chArray
        
        for roomIndex in 0..<totalRooms {
            
            
            if let numChildren = Int(chArray[roomIndex]), numChildren > 0 {
                var childAges: [String] = Array(repeating: "0", count: numChildren)
                
                if numChildren > 2 {
                    childAges.append("0")
                }
                
                payload["childAge_\(roomIndex + 1)"] = childAges
            }
        }
        
        
        payload["nationality"] = defaults.string(forKey: UserDefaultsKeys.hnationalitycode) ?? "KW"
        payload["language"] = "english"
        payload["search_source"] = "IOS"
        payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        if defaults.string(forKey: UserDefaultsKeys.locationcity) == "Add City" || defaults.string(forKey: UserDefaultsKeys.locationcity) == nil{
            showToast(message: "Enter Hotel or City ")
        }else if defaults.string(forKey: UserDefaultsKeys.checkin) == "Add Check In Date" || defaults.string(forKey: UserDefaultsKeys.checkin) == nil{
            showToast(message: "Enter Checkin Date")
        }else if defaults.string(forKey: UserDefaultsKeys.checkout) == "Add Check Out Date" || defaults.string(forKey: UserDefaultsKeys.checkout) == nil{
            showToast(message: "Enter Checkout Date")
        }else if defaults.string(forKey: UserDefaultsKeys.checkout) == defaults.string(forKey: UserDefaultsKeys.checkin) {
            showToast(message: "Enter Different Dates")
        }else if defaults.string(forKey: UserDefaultsKeys.roomcount) == "" {
            showToast(message: "Add Rooms For Booking")
        }else if defaults.string(forKey: UserDefaultsKeys.hnationality) == "Nationality" {
            showToast(message: "Please Select Nationality.")
        }else if checkDepartureAndReturnDates(payload, p1: "hotel_checkin", p2: "hotel_checkout") == false {
            showToast(message: "Invalid Date")
        }else {
            
            
            do{
                
                let jsonData = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
                let jsonStringData =  NSString(data: jsonData as Data, encoding: NSUTF8StringEncoding)! as String
                
                print(jsonStringData)
                
                
            }catch{
                print(error.localizedDescription)
            }
            
            gotoSearchHotelsResultVC()
            
        }
    }
    
    
    func gotoSearchHotelsResultVC(){
        defaults.set(false, forKey: "hoteltfilteronce")
        guard let vc = HotelSearchResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.nationalityCode = self.nationalityCode
        callapibool = true
        vc.payload = payload
        present(vc, animated: true)
    }
    
    
}
