//
//  SelectedFlightInfoVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 18/08/22.
//

import UIKit

class SelectedFlightInfoVC: BaseTableVC {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var itineraryCV: UICollectionView!
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
    var itineraryArray = ["Itinerary","Fare Breakdown","Fare Rules","Baggage Info"]
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
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                
                
            }else if journeyType == "circle"{
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "0") ?? 0
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(stopTimer), name: NSNotification.Name("sessionStop"), object: nil)
    }
    
    @objc func stopTimer() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func callAPI() {
        
        payload["search_id"] = searchid
        payload["booking_source"] = bookingsource
        payload["access_key"] = accesskey
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        vm?.CALL_GET_FLIGHT_DETAILS_API(dictParam: payload)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        vm = FDViewModel(self)
    }
    
    
    func setupUI() {
        
        booknowHolderView.isHidden = true
        nav.isHidden = true
        navHeight.constant = 160
        holderView.backgroundColor = .WhiteColor
        nav.titlelbl.text = ""
        nav.backBtn.addTarget(self, action: #selector(gotoBackScreen), for: .touchUpInside)
        nav.citylbl.isHidden = false
        nav.datelbl.isHidden = false
        //   nav.travellerlbl.isHidden = false
        
        setuplabels(lbl: nav.titlelbl, text: defaults.string(forKey: UserDefaultsKeys.journyCitys) ?? "", textcolor: .AppLabelColor, font: .OpenSansBold(size: 14), align: .left)
        setuplabels(lbl: nav.citylbl, text: "\(defaults.string(forKey: UserDefaultsKeys.journyDates) ?? ""), \(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "")", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12), align: .left)
        
        
        
        
        setupViews(v: booknowHolderView, radius: 0, color: .AppBackgroundColor)
        setupViews(v: bookNowView, radius: 20, color: .AppBtnColor)
        bookNowView.backgroundColor = .layoverColor
        setuplabels(lbl: titlelbl, text: "KWD:150.00", textcolor: .WhiteColor, font: .oswaldRegular(size: 20), align: .left)
        setuplabels(lbl: bookNowlbl, text: "BOOK NOW", textcolor: .AppLabelColor, font: .oswaldRegular(size: 16), align: .center)
        bookNowBtn.setTitle("", for: .normal)
        
        commonTableView.registerTVCells(["AddItineraryTVCell",
                                         "EmptyTVCell",
                                         "TitleLblTVCell",
                                         "FareBreakdownTVCell",
                                         "BaggageInfoTVCell",
                                         "FareRulesDataTVCell",
                                         "FareRulesTVCell",
                                         "RadioButtonTVCell"])
        
        
        
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.2
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    
    @objc func gotoBackScreen() {
        callapibool = false
        NotificationCenter.default.post(name: NSNotification.Name("backvc"), object: nil)
        dismiss(animated: true)
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
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        
        
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
            
            tablerow.append(TableRow(title:"Infanta",
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
            
            tablerow.append(TableRow(title:"Infanta",
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
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        setupFareRulesTVCells()
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        setupBaggageInfoTVCells()
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func setupFareRulesTVCells() {
        
        self.commonTableView.estimatedRowHeight = 500
        self.commonTableView.rowHeight = 40
        
        tablerow.append(TableRow(title:"Fare Rules",subTitle: "",key: "title",cellType:.TitleLblTVCell))
        //        tablerow.append(TableRow(moreData:fareRulesData,cellType:.FareRulesDataTVCell))
        
        
        if fareRulesData.isEmpty == true || fareRulesData.count == 0 {
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
        }else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            fareRulesData.forEach { i in
                tablerow.append(TableRow(title:i.rule_heading,subTitle: i.rule_content,cellType:.FareRulesTVCell))
            }
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
    
    
    @IBAction func didTapOnBookNowBtn(_ sender: Any) {
        guard let vc = PayNowVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.keystr = "flight"
        callapibool = true
        self.present(vc, animated: true)
    }
    
    
    
    
}




extension SelectedFlightInfoVC: FDViewModelDelegate {
    
    func flightDetails(response: FDModel) {
        booknowHolderView.isHidden = false
        //  cvHolderView.isHidden = false
        nav.isHidden = false
        titlelbl.text = "\(response.priceDetails?.api_currency ?? ""):\(response.priceDetails?.grand_total ?? "")"
        grandTotal = "\(response.priceDetails?.api_currency ?? ""):\(response.priceDetails?.grand_total ?? "")"
        jm = response.journeySummary ?? []
        fd = response.flightDetails ?? [[]]
        fareRulesData = response.fareRulehtml ?? []
        farepricedetails = response.priceDetails
        
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
            // setupItineraryTVCells()
            setupFareBreakdownTVCells()
        }
    }
    
}


extension SelectedFlightInfoVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FareRulesTVCell {
            if cell.showBool == true {
                cell.show()
                cell.showBool = false
            }else {
                cell.hide()
                cell.showBool = true
            }
        }
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    
    //    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    //        if let cell = tableView.cellForRow(at: indexPath) as? FareRulesTVCell {
    //            cell.hide()
    //        }
    //
    //    }
}
