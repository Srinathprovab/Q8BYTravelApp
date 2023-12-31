//
//  SelectedFlightInfoVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 18/08/22.
//

import UIKit

class SelectedFlightInfoVC: BaseTableVC, TimerManagerDelegate, FDViewModelDelegate {
    
    
    @IBOutlet weak var dateslbl: UILabel!
    @IBOutlet weak var citycodelbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var booknowHolderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    
    static var newInstance: SelectedFlightInfoVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectedFlightInfoVC
        return vc
    }
    var isVcFrom = String()
    var city = String()
    var date = String()
    var traveller = String()
    var tablerow = [TableRow]()
    var farepricedetails:PriceDetails?
    var jm = [JourneySummary]()
    
    var cellIndex = Int()
    var vm:FDViewModel?
    var newString = ""
    var payload = [String:Any]()
    var adultsCount = Int()
    var childCount = Int()
    var infantsCount = Int()
    var dropdownBool = true
    var acessKey = String()
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        vm = FDViewModel(self)
    }
    
    
    func setupUI() {
        
        holderView.isHidden = true
        citycodelbl.text = defaults.string(forKey: UserDefaultsKeys.journyCitys) ?? ""
        dateslbl.text = "\(defaults.string(forKey: UserDefaultsKeys.journyDates) ?? ""), \(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "")"
        
        commonTableView.registerTVCells(["AddItineraryTVCell",
                                         "EmptyTVCell",
                                         "TitleLblTVCell",
                                         "FareBreakdownTVCell",
                                         "BaggageInfoTVCell",
                                         "FareRulesDataTVCell",
                                         "FareRulesTVCell",
                                         "RadioButtonTVCell","AddFareRulesTVCell"])
        
        
        
    }
    
    
    
    @IBAction func didTapOnBookNowBtn(_ sender: Any) {
        guard let vc = PayNowVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.keystr = "flight"
        callapibool = true
        self.present(vc, animated: true)
    }
    
    
    override func didTapOnFareRulesBtnAction(cell: AddFareRulesTVCell) {
        commonTableView.reloadData()
    }
    
    
    override func showContentBtnAction(cell:FareRulesTVCell){
        if cell.showBool == true {
            cell.show()
            cell.showBool = false
        }else {
            cell.hide()
            cell.showBool = true
        }
        
        
        commonTableView.reloadData()
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        NotificationCenter.default.post(name: NSNotification.Name("backvc"), object: nil)
        dismiss(animated: true)
    }
    
}



extension SelectedFlightInfoVC {
    func callAPI() {
        
        payload["search_id"] = searchid
        payload["booking_source"] = bookingsource
        payload["access_key"] = accesskey
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        vm?.CALL_GET_FLIGHT_DETAILS_API(dictParam: payload)
    }
    
    
    func flightDetails(response: FDModel) {
        
        holderView.isHidden = false
        titlelbl.text = "\(response.priceDetails?.api_currency ?? ""):\(response.priceDetails?.grand_total ?? "")"
        grandTotal = "\(response.priceDetails?.api_currency ?? ""):\(response.priceDetails?.grand_total ?? "")"
        jm = response.journeySummary ?? []
        fd = response.flightDetails ?? [[]]
        fareRulesData = response.fareRulehtml ?? []
        farepricedetails = response.priceDetails
        newpriceDetails = response.priceDetails
        Adults_Base_Price = String(response.priceDetails?.adultsBasePrice ?? "0")
        Adults_Tax_Price = String(response.priceDetails?.adultsTaxPrice ?? "0")
        Childs_Base_Price = String(response.priceDetails?.childBasePrice ?? "0")
        Childs_Tax_Price = String(response.priceDetails?.childTaxPrice ?? "0")
        Infants_Base_Price = String(response.priceDetails?.infantBasePrice ?? "0")
        Infants_Tax_Price = String(response.priceDetails?.infantTaxPrice ?? "0")
        AdultsTotalPrice = String(response.priceDetails?.adultsTotalPrice ?? "0")
        ChildTotalPrice = String(response.priceDetails?.childTotalPrice ?? "0")
        InfantTotalPrice = String(response.priceDetails?.infantTotalPrice ?? "0")
        sub_total_adult = String(response.priceDetails?.sub_total_adult ?? "0")
        sub_total_child = String(response.priceDetails?.sub_total_child ?? "0")
        sub_total_infant = String(response.priceDetails?.sub_total_infant ?? "0")
        
        DispatchQueue.main.async {[self] in
            setupFareBreakdownTVCells()
        }
        
    }
    
    
    func setupItineraryTVCells() {
        
        tablerow.append(TableRow(title:"Itinerary",subTitle: "",key: "title",cellType:.TitleLblTVCell))
        fd.forEach { i in
            tablerow.append(TableRow(moreData:i,cellType:.AddItineraryTVCell))
        }
        
    }
    
    
    func setupFareBreakdownTVCells() {
        commonTableView.separatorColor = .clear
        tablerow.removeAll()
        
        
        setupItineraryTVCells()
        
        
        
        tablerow.append(TableRow(title:"Fare Breakdown",subTitle: "",key: "title",cellType:.TitleLblTVCell))
        if adultsCount > 0 && childCount == 0 && infantsCount == 0 {
            tablerow.append(TableRow(title:"Adult",
                                     subTitle: "X\(String(adultsCount))",
                                     key:farepricedetails?.api_currency,
                                     text: farepricedetails?.adultsBasePrice,
                                     headerText: farepricedetails?.sub_total_adult,
                                     buttonTitle:farepricedetails?.adultsTotalPrice,
                                     errormsg:farepricedetails?.adultsTotalPrice,
                                     key1:farepricedetails?.grand_total,
                                     tempText: farepricedetails?.adultsTaxPrice,
                                     cellType:.FareBreakdownTVCell,
                                     questionBase: "fare"))
            
            
            
        }else if adultsCount > 0 && childCount > 0 && infantsCount == 0 {
            tablerow.append(TableRow(title:"Adult",
                                     subTitle: "X\(String(adultsCount))",
                                     key:farepricedetails?.api_currency,
                                     text: farepricedetails?.adultsBasePrice,
                                     headerText: farepricedetails?.sub_total_adult,
                                     buttonTitle:farepricedetails?.adultsTotalPrice,
                                     errormsg:farepricedetails?.adultsTotalPrice,
                                     key1:farepricedetails?.grand_total,
                                     tempText: farepricedetails?.adultsTaxPrice,
                                     cellType:.FareBreakdownTVCell,
                                     questionBase: "fare"))
            
            tablerow.append(TableRow(height:5,cellType:.EmptyTVCell))
            
            tablerow.append(TableRow(title:"Child",
                                     subTitle: "X\(String(childCount))",
                                     key:farepricedetails?.api_currency,
                                     text: farepricedetails?.childBasePrice,
                                     headerText: farepricedetails?.sub_total_child,
                                     buttonTitle:farepricedetails?.childTotalPrice,
                                     key1:farepricedetails?.grand_total,
                                     tempText: farepricedetails?.childTaxPrice,
                                     cellType:.FareBreakdownTVCell,
                                     questionBase: "fare"))
            
        }else if adultsCount > 0 && childCount == 0 && infantsCount > 0 {
            tablerow.append(TableRow(title:"Adult",
                                     subTitle: "X\(String(adultsCount))",
                                     key:farepricedetails?.api_currency,
                                     text: farepricedetails?.adultsBasePrice,
                                     headerText: farepricedetails?.sub_total_adult,
                                     buttonTitle:farepricedetails?.adultsTotalPrice,
                                     key1:farepricedetails?.grand_total,
                                     tempText: farepricedetails?.adultsTaxPrice,
                                     cellType:.FareBreakdownTVCell,
                                     questionBase: "fare"))
            
            tablerow.append(TableRow(height:5,cellType:.EmptyTVCell))
            
            tablerow.append(TableRow(title:"Infant",
                                     subTitle: "X\(String(infantsCount))",
                                     key:farepricedetails?.api_currency,
                                     text: farepricedetails?.infantBasePrice,
                                     headerText: farepricedetails?.sub_total_infant,
                                     buttonTitle:farepricedetails?.infantTotalPrice,
                                     key1:farepricedetails?.grand_total,
                                     tempText: farepricedetails?.infantTaxPrice,
                                     cellType:.FareBreakdownTVCell,
                                     questionBase: "fare"))
        }else {
            tablerow.append(TableRow(title:"Adult",
                                     subTitle: "X\(String(adultsCount))",
                                     key:farepricedetails?.api_currency,
                                     text: farepricedetails?.adultsBasePrice,
                                     headerText: farepricedetails?.sub_total_adult,
                                     buttonTitle:farepricedetails?.adultsTotalPrice,
                                     key1:farepricedetails?.grand_total,
                                     tempText: farepricedetails?.adultsTaxPrice,
                                     cellType:.FareBreakdownTVCell,
                                     questionBase: "fare"))
            
            tablerow.append(TableRow(height:5,cellType:.EmptyTVCell))
            
            tablerow.append(TableRow(title:"Child",
                                     subTitle: "X\(String(childCount))",
                                     key:farepricedetails?.api_currency,
                                     text: farepricedetails?.childBasePrice,
                                     headerText: farepricedetails?.sub_total_child,
                                     buttonTitle:farepricedetails?.childTotalPrice,
                                     errormsg:farepricedetails?.childTotalPrice,
                                     key1:farepricedetails?.grand_total,
                                     tempText: farepricedetails?.childTaxPrice,
                                     cellType:.FareBreakdownTVCell,
                                     questionBase: "fare"))
            
            tablerow.append(TableRow(height:5,cellType:.EmptyTVCell))
            
            tablerow.append(TableRow(title:"Infant",
                                     subTitle: "X\(String(infantsCount))",
                                     key:farepricedetails?.api_currency,
                                     text: farepricedetails?.infantBasePrice,
                                     headerText: farepricedetails?.sub_total_infant,
                                     buttonTitle:farepricedetails?.infantTotalPrice,
                                     key1:farepricedetails?.grand_total,
                                     tempText: farepricedetails?.infantTaxPrice,
                                     cellType:.FareBreakdownTVCell,
                                     questionBase: "fare"))
        }
        
        
        tablerow.append(TableRow(title:"Total Trip Cost",subTitle: farepricedetails?.grand_total,key: "totalcost",cellType:.TitleLblTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))

        setupFareRulesTVCells()
        setupBaggageInfoTVCells()
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func setupFareRulesTVCells() {
        if fareRulesData.count != 0 {
            tablerow.append(TableRow(cellType:.AddFareRulesTVCell))
        }
    }
    
    
    func setupBaggageInfoTVCells() {
        commonTableView.separatorColor = .clear
        
        
        tablerow.append(TableRow(title:"Baggage Information",subTitle: "",key: "title",cellType:.TitleLblTVCell))
        
        jm.forEach { j in
            tablerow.append(TableRow(title:"\(j.from_city ?? "")-\(j.to_city ?? "")",
                                     subTitle: j.cabin_baggage ?? "",
                                     buttonTitle: j.Weight_Allowance ?? "",
                                     cellType:.BaggageInfoTVCell))
            
        }
        
    }
    
}



extension SelectedFlightInfoVC {
    
    func addObserver() {
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                
                
            }else if journeyType == "circle"{
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
            }else {
                
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0") ?? 0
            }
        }
        
        if callapibool == true {
            DispatchQueue.main.async {[self] in
                callAPI()
            }
        }
        
        TimerManager.shared.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernetreload), name: NSNotification.Name("nointernetreload"), object: nil)

    }
    
    
    @objc func nointernetreload(){
        
        DispatchQueue.main.async {[self] in
            callAPI()
        }
        
    }
    
    
    
    
    
    @objc func reload(){
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    @objc func nointernet(){
        gotoNoInternetConnectionVC(key: "nointernet", titleStr: "")
    }
    
    @objc func resultnil(){
        gotoNoInternetConnectionVC(key: "noresult", titleStr: "NO AVAILABILITY FOR THIS REQUEST")
    }
    
    
    
    
    func gotoNoInternetConnectionVC(key:String,titleStr:String) {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = key
        vc.key = titleStr
        self.present(vc, animated: false)
    }
    
    
    func timerDidFinish() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func updateTimer() {
        
    }
    
    
}
