//
//  ModifyFlightSearchVC.swift
//  QBBYTravelApp
//
//  Created by FCI on 19/04/23.
//

import UIKit

class ModifyFlightSearchVC: BaseTableVC {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var oneWayView: UIView!
    @IBOutlet weak var oneWaylbl: UILabel!
    @IBOutlet weak var oneWayBtn: UIButton!
    @IBOutlet weak var roundTripView: UIView!
    @IBOutlet weak var roundTriplbl: UILabel!
    @IBOutlet weak var roundTripBtn: UIButton!
    @IBOutlet weak var multicityView: UIView!
    @IBOutlet weak var multicitylbl: UILabel!
    @IBOutlet weak var multicityBtn: UIButton!
    
    var isVcFrom = String()
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var payload2 = [String:Any]()
    var fromdataArray = [[String:Any]]()
    
    static var newInstance: ModifyFlightSearchVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifyFlightSearchVC
        return vc
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
    }
    
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
       // self.view.backgroundColor = .clear
        self.holderView.backgroundColor = .WhiteColor
        
        
        buttonsView.addCornerRadiusWithShadow(color: .lightGray, borderColor: .AppBorderColor, cornerRadius: 20)
        buttonsView.backgroundColor = .WhiteColor
        //  setupViews(v: buttonsView, radius: 20, color: .WhiteColor)
        setupViews(v: oneWayView, radius: 18, color: .AppBackgroundColor)
        setupViews(v: roundTripView, radius: 18, color: .WhiteColor)
        setupViews(v: multicityView, radius: 18, color: .WhiteColor)
        multicityView.isHidden = true
        
        setupLabels(lbl: oneWaylbl, text: "One Way", textcolor: .WhiteColor, font: .OpenSansRegular(size: 16))
        setupLabels(lbl: roundTriplbl, text: "Round Trip", textcolor: .AppSubtitleColor, font: .OpenSansRegular(size: 16))
        setupLabels(lbl: multicitylbl, text: "Multicity", textcolor: .AppSubtitleColor, font: .OpenSansRegular(size: 16))
        
        
        oneWayBtn.setTitle("", for: .normal)
        roundTripBtn.setTitle("", for: .normal)
        multicityBtn.setTitle("", for: .normal)
        
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "SearchFlightTVCell",
                                         "DashboardDealsTitleTVCell",
                                         "FlightRelatedSearchTVCell",
                                         "FlightSearchTVCell",
                                         "AddCityTVCell",
                                         "MultiCityTripTVCell"])
        
        appendTvcells(str: "oneway")
        if let selectedJourneyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if selectedJourneyType == "multicity" {
                setupMulticity()
            }else if selectedJourneyType == "circle" {
                setupRoundTrip()
            }else {
                setupOneWay()
            }
        }
        
    }
    
    
    func appendTvcells(str:String) {
        tablerow.removeAll()
        
        tablerow.append(TableRow(key:str,cellType:.FlightSearchTVCell))
        tablerow.append(TableRow(height:20,bgColor: .AppHolderViewColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.FlightRelatedSearchTVCell))
        tablerow.append(TableRow(height:30,bgColor: .AppHolderViewColor,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    func appendMulticityTvcells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.AddCityTVCell))
        tablerow.append(TableRow(height:20,bgColor: .AppHolderViewColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.FlightRelatedSearchTVCell))
        tablerow.append(TableRow(height:30,bgColor: .AppHolderViewColor,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.2
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    
    @IBAction func didTapOnOneWayBtn(_ sender: Any) {
        setupOneWay()
    }
    
    @IBAction func didTapOnRoundTripBtn(_ sender: Any) {
        setupRoundTrip()
    }
    
    
    @IBAction func didTapOnMulticityBtn(_ sender: Any) {
        setupMulticity()
    }
    
    func setupOneWay() {
        oneWaylbl.textColor = .WhiteColor
        roundTriplbl.textColor = .AppSubtitleColor
        multicitylbl.textColor = .AppSubtitleColor
        
        oneWayView.backgroundColor = .AppBackgroundColor
        roundTripView.backgroundColor = .WhiteColor
        multicityView.backgroundColor = .WhiteColor
        
        defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
        appendTvcells(str: "oneway")
    }
    
    
    func setupRoundTrip() {
        oneWaylbl.textColor = .AppSubtitleColor
        roundTriplbl.textColor = .WhiteColor
        multicitylbl.textColor = .AppSubtitleColor
        
        oneWayView.backgroundColor = .WhiteColor
        roundTripView.backgroundColor = .AppBackgroundColor
        multicityView.backgroundColor = .WhiteColor
        
        defaults.set("circle", forKey: UserDefaultsKeys.journeyType)
        NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
        appendTvcells(str: "roundtrip")
    }
    
    
    func setupMulticity() {
        oneWaylbl.textColor = .AppSubtitleColor
        roundTriplbl.textColor = .AppSubtitleColor
        multicitylbl.textColor = .WhiteColor
        
        oneWayView.backgroundColor = .WhiteColor
        roundTripView.backgroundColor = .WhiteColor
        multicityView.backgroundColor = .AppBackgroundColor
        
        defaults.set("multicity", forKey: UserDefaultsKeys.journeyType)
        appendMulticityTvcells()
    }
    
    
    
    override func didTapOnFromCity(cell: FlightSearchTVCell) {
        gotoSelectCityVC(str: "From", celltag1: 0)
    }
    
    override func didTapOnToCity(cell: FlightSearchTVCell) {
        gotoSelectCityVC(str: "To", celltag1: 0)
    }
    
    override func didTapOnSelectDepDateBtn(cell: FlightSearchTVCell) {
        gotoCalenderVC(celltag1: 0)
    }
    override func didTapOnSelectRepDateBtn(cell: FlightSearchTVCell) {
        gotoCalenderVC(celltag1: 0)
    }
    
    
    override func didTapOnAddTravelerEconomy(cell:FlightSearchTVCell){
        gotoAddTravelerVC()
    }
    
    func gotoSelectCityVC(str:String,celltag1:Int) {
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = str
        //vc.celltag = celltag1
        self.present(vc, animated: true)
    }
    
    func gotoCalenderVC(celltag1:Int) {
        guard let vc = Calvc.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.celltag = celltag1
        self.present(vc, animated: false)
    }
    
    func gotoAddTravelerVC() {
        guard let vc = TravellerEconomyVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    override func didTapOnSearchFlightsBtn(cell:FlightSearchTVCell) {
        
        payload.removeAll()
        
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journyType == "oneway" {
            
            payload["trip_type"] = defaults.string(forKey: UserDefaultsKeys.journeyType)
            payload["adult"] = defaults.string(forKey: UserDefaultsKeys.adultCount)
            payload["child"] = defaults.string(forKey: UserDefaultsKeys.childCount)
            payload["infant"] = defaults.string(forKey: UserDefaultsKeys.infantsCount)
            payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy"
            payload["sector_type"] = "international"
            payload["from"] = defaults.string(forKey: UserDefaultsKeys.fromCity)
            payload["from_loc_id"] = defaults.string(forKey: UserDefaultsKeys.fromlocid)
            payload["to"] = defaults.string(forKey: UserDefaultsKeys.toCity)
            payload["to_loc_id"] = defaults.string(forKey: UserDefaultsKeys.tolocid)
            payload["depature"] = defaults.string(forKey: UserDefaultsKeys.calDepDate)
            payload["return"] = ""
            payload["out_jrn"] = "All Times"
            payload["ret_jrn"] = "All Times"
            payload["carrier"] = ""
            payload["psscarrier"] = defaults.string(forKey: UserDefaultsKeys.airlinescode) ?? "ALL"
            payload["search_flight"] = "Search"
            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            payload["search_source"] = "IOS"
            
            
            if defaults.string(forKey:UserDefaultsKeys.fromCity) == nil {
                showToast(message: "Please Select From City")
            }else if defaults.string(forKey:UserDefaultsKeys.toCity) == nil {
                showToast(message: "Please Select To City")
            }else if defaults.string(forKey:UserDefaultsKeys.toCity) == defaults.string(forKey:UserDefaultsKeys.fromCity) {
                showToast(message: "Please Select Different Citys")
            }else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == "Add Date" ||  defaults.string(forKey:UserDefaultsKeys.calDepDate) == nil{
                showToast(message: "Please Select Departure Date")
            }else if defaults.string(forKey:UserDefaultsKeys.travellerDetails) == "Add Details" {
                showToast(message: "Add Traveller")
            }else if defaults.string(forKey:UserDefaultsKeys.selectClass) == "Add Details" {
                showToast(message: "Add Class")
            }else if checkDepartureAndReturnDates1(payload, p1: "depature") == false {
                showToast(message: "Invalid Date")
            }else{
                gotoSearchFlightResultVC(payload33: payload)
            }
        }
        
        else if journyType == "circle"{
            
            payload["trip_type"] = defaults.string(forKey: UserDefaultsKeys.journeyType)
            payload["adult"] = defaults.string(forKey: UserDefaultsKeys.radultCount)
            payload["child"] = defaults.string(forKey: UserDefaultsKeys.rchildCount)
            payload["infant"] = defaults.string(forKey: UserDefaultsKeys.rinfantsCount)
            payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.rselectClass) ?? "Economy"
            payload["sector_type"] = "international"
            payload["from"] = defaults.string(forKey: UserDefaultsKeys.fromCity)
            payload["from_loc_id"] = defaults.string(forKey: UserDefaultsKeys.fromlocid)
            payload["to"] = defaults.string(forKey: UserDefaultsKeys.toCity)
            payload["to_loc_id"] = defaults.string(forKey: UserDefaultsKeys.tolocid)
            payload["depature"] = defaults.string(forKey: UserDefaultsKeys.calDepDate)
            payload["return"] = defaults.string(forKey: UserDefaultsKeys.calRetDate)
            payload["out_jrn"] = "All Times"
            payload["ret_jrn"] = "All Times"
            payload["carrier"] = ""
            //  payload["direct_flight"] = "on"
            payload["psscarrier"] = defaults.string(forKey: UserDefaultsKeys.airlinescode) ?? "ALL"
            payload["search_flight"] = "Search"
            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            payload["search_source"] = "IOS"
            
            
            if defaults.string(forKey:UserDefaultsKeys.fromCity) == nil {
                showToast(message: "Please Select From City")
            }else if defaults.string(forKey:UserDefaultsKeys.toCity) == nil {
                showToast(message: "Please Select To City")
            }else if defaults.string(forKey:UserDefaultsKeys.toCity) == defaults.string(forKey:UserDefaultsKeys.fromCity) {
                showToast(message: "Please Select Different Citys")
            }else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == "Add Date" ||  defaults.string(forKey:UserDefaultsKeys.calDepDate) == nil{
                showToast(message: "Please Select Departure Date")
            }else if defaults.string(forKey:UserDefaultsKeys.calRetDate) == "Add Return" ||  defaults.string(forKey:UserDefaultsKeys.calRetDate) == nil{
                showToast(message: "Please Select Return Date")
            }else if defaults.string(forKey:UserDefaultsKeys.rtravellerDetails) == "Add Details" {
                showToast(message: "Add Traveller")
            }else if defaults.string(forKey:UserDefaultsKeys.rselectClass) == "Add Details" {
                showToast(message: "Add Class")
            }else if checkDepartureAndReturnDates(payload, p1: "depature", p2: "return") == false {
                showToast(message: "Invalid Date")
            }else{
                gotoSearchFlightResultVC(payload33: payload)
            }
        }
        
        else {
            
        }
        
    }
    
    override func didTapOnFromBtn(cell:MulticityFromToTVCell){
        gotoSelectCityVC(str: "From", celltag1: cell.fromBtn.tag)
    }
    override func didTapOnToBtn(cell:MulticityFromToTVCell){
        gotoSelectCityVC(str: "To", celltag1: cell.toBtn.tag)
    }
    override func didTapOndateBtn(cell:MulticityFromToTVCell){
        gotoCalenderVC(celltag1: cell.dateBtn.tag)
        
        
    }
    override func didTapOnCloseBtn(cell:MulticityFromToTVCell){
        print("didTapOnCloseBtn")
    }
    override func didTapOnAddTravellerEconomy(cell:HolderViewTVCell){
        gotoAddTravelerVC()
    }
    
    override func didTapOnMultiCityTripSearchFlight(cell:ButtonTVCell){
        
        payload.removeAll()
        payload2.removeAll()
        payload1.removeAll()
        fromdataArray.removeAll()
        
        for (index,_) in fromCityNameArray.enumerated() {
            
            payload2["from"] = fromCityNameArray[index]
            payload2["from_loc_id"] = fromlocidArray[index]
            payload2["to"] = toCityNameArray[index]
            payload2["to_loc_id"] = tolocidArray[index]
            payload2["depature"] = depatureDatesArray[index]
            
            fromdataArray.append(payload2)
        }
        
        
        payload1["sector_type"] = "international"
        payload1["trip_type"] = defaults.string(forKey:UserDefaultsKeys.journeyType)
        payload1["adult"] = defaults.string(forKey: UserDefaultsKeys.madultCount)
        payload1["child"] = defaults.string(forKey: UserDefaultsKeys.mchildCount)
        payload1["infant"] = defaults.string(forKey: UserDefaultsKeys.minfantsCount)
        payload1["checkbox-group"] = "on"
        payload1["search_flight"] = "Search"
        payload1["anNonstopflight"] = "1"
        payload1["carrier"] = ""
        payload1["psscarrier"] = "ALL"
        payload1["remngwd"] = defaults.string(forKey: UserDefaultsKeys.mselectClass)
        payload1["v_class"] = defaults.string(forKey: UserDefaultsKeys.mselectClass)
        payload1["user_id"] = "0"
        payload1["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "AED"
        payload1["placeDetails"] = fromdataArray
        
        var showToastMessage: String? = nil
        
        for cityName in fromCityNameArray {
            if cityName == "From" {
                showToastMessage = "Please Select Origin"
                break
            }
        }
        
        if showToastMessage == nil {
            for cityName in toCityNameArray {
                if cityName == "To" {
                    showToastMessage = "Please Select Destination"
                    break
                }
            }
        }
        
        if showToastMessage == nil {
            for date in depatureDatesArray {
                if date == "Date" {
                    showToastMessage = "Please Select Date"
                    break
                }
            }
        }
        
        
        
        if showToastMessage == nil {
            if depatureDatesArray != depatureDatesArray.sorted() {
                showToastMessage = "Please Select Dates in Ascending Order"
            } else if depatureDatesArray.count == 2 && depatureDatesArray[0] == depatureDatesArray[1] {
                showToastMessage = "Please Select Different Dates"
            }
        }
        
        
        
        if let message = showToastMessage {
            showToast(message: message)
        } else {
            gotoSearchFlightResultVC(payload33: payload)
        }
        
        
        
    }
    
    
    @IBAction func didTapOnCloseBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    func gotoSearchFlightResultVC(payload33:[String:Any]) {
        defaults.set(false, forKey: "flightfilteronce")
        guard let vc = SearchFlightResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.isvcfrom = "bookflightvc"
        vc.payload = payload33
        callapibool = true
        self.present(vc, animated: true)
    }
    
    
    
    override func didTapOnAirlineBtnAction(cell:FlightSearchTVCell) {
        gotoNationalityVC()
    }
    
    func gotoNationalityVC(){
        guard let vc = NationalityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    //MARK: - donedatePicker cancelDatePicker
    
//    override func donedatePicker(cell:SearchFlightTVCell){
//        
//
//        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
//        if journyType == "oneway" {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "dd-MM-yyyy"
//            defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.calDepDate)
//
//        }else {
//
//            let formatter = DateFormatter()
//            formatter.dateFormat = "dd-MM-yyyy"
//            defaults.set(formatter.string(from: cell.retdepDatePicker.date), forKey: UserDefaultsKeys.rcalDepDate)
//            defaults.set(formatter.string(from: cell.retDatePicker.date), forKey: UserDefaultsKeys.rcalRetDate)
//        }
//
//        commonTableView.reloadData()
//        self.view.endEditing(true)
//    }
//
//    override func cancelDatePicker(cell:SearchFlightTVCell){
//        self.view.endEditing(true)
//    }
    
}
