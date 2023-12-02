//
//  PayNowVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 18/08/22.
//

import UIKit
import CoreData

class PayNowVC: BaseTableVC,HotelMBViewModelDelegate,TimerManagerDelegate, PreBookingViewModelDelegate  {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    @IBOutlet weak var booknowHolderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    
    var payemail = String()
    var paymobile = String()
    var paycountryCode = String()
    
    
    static var newInstance: PayNowVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? PayNowVC
        return vc
    }
    
    var tablerow = [TableRow]()
    var keystr = String()
    
    var email = String()
    var mobile = String()
    var countryCode = String()
    var billingCountryCode = String()
    var billingCountryName = String()
    var tmpFlightPreBookingId = String()
    var tokenkey = String()
    
    var adultsCount = Int()
    var childCount = Int()
    var infantsCount = Int()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var details  = [NSFetchRequestResult]()
    
    var fnameA = [String]()
    var passengertypeA = [String]()
    var title2A = [String]()
    var mnameA = [String]()
    var lnameA = [String]()
    var dobA = [String]()
    var passportNoA = [String]()
    var countryCodeA = [String]()
    var genderA = [String]()
    var passportexpiryA = [String]()
    var passportissuingcountryA = [String]()
    var middleNameA = [String]()
    var leadPassengerA = [String]()
    var activepaymentoptions = String()
    var vm:PreBookingViewModel?
    var vm2:HotelMBViewModel?
    var flightSummery = [Summary] ()
    var hoteldetails : HotelMBHotelDetails?
    var hcurrency = String()
    var securebooingbool = false
    var positionsCount = 0
    var searchidnew = String()
    
    var promocodeBool = false
    var promocodeValue = String()
    var promocodeString = ""
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm = PreBookingViewModel(self)
        vm2 = HotelMBViewModel(self)
        
        setupUI()
    }
    
    
    
    func setupUI() {
        
        navHeight.constant = 174
        holderView.isHidden = false
        holderView.backgroundColor = .WhiteColor
        nav.backBtn.addTarget(self, action: #selector(gotoBackScreen), for: .touchUpInside)
        nav.citylbl.isHidden = false
        nav.datelbl.isHidden = false
        
        booknowHolderView.backgroundColor = .AppBackgroundColor
        bookNowView.backgroundColor = .layoverColor
        bookNowView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 20)
        setuplabels(lbl: titlelbl, text: grandTotal, textcolor: .WhiteColor, font: .oswaldRegular(size: 20), align: .left)
        setuplabels(lbl: bookNowlbl, text: "PAY NOW", textcolor: .AppLabelColor, font: .oswaldRegular(size: 16), align: .center)
        bookNowBtn.setTitle("", for: .normal)
        bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowBtn(_:)), for: .touchUpInside)
        
        commonTableView.registerTVCells(["TDetailsLoginTVCell",
                                         "EmptyTVCell",
                                         "PromocodeTVCell",
                                         "PriceSummaryTVCell",
                                         "HotelPurchaseSummaryTVCell",
                                         "ContactInformationTVCell",
                                         "AcceptTermsAndConditionTVCell",
                                         "RoundTripTVcell",
                                         "HotelSearchResultTVCell",
                                         "AddDeatilsOfTravellerTVCell",
                                         "AddDeatilsOfGuestTVCell",
                                         "TotalNoofTravellerTVCell"])
        
        
        
    }
    
    
    @objc func gotoBackScreen() {
        callapibool = false
        if securebooingbool == false {
            dismiss(animated: true)
        }else {
            guard let vc = BookFlightVC.newInstance.self else {return}
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
        
    }
    
    
    func setupTVCells() {
        tablerow.removeAll()
        
        
        if flightSummery.count != 0 {
            setupRoundTripTVCells()
        }
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
            tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
        }
        
        
        passengertypeArray.removeAll()
        tablerow.append(TableRow(height:20, bgColor:.AppHolderViewColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Passenger Details",cellType:.TotalNoofTravellerTVCell))
        for i in 1...adultsCount {
            positionsCount += 1
            passengertypeArray.append("Adult")
            let travellerCell = TableRow(title: "Adult \(i)", key: "adult", headerText: "Mr",characterLimit: positionsCount, cellType: .AddDeatilsOfTravellerTVCell)
            tablerow.append(travellerCell)
            
        }
        
        
        if childCount != 0 {
            for i in 1...childCount {
                positionsCount += 1
                passengertypeArray.append("Child")
                tablerow.append(TableRow(title:"Child \(i)",key:"child",headerText: "Master",characterLimit: positionsCount,cellType:.AddDeatilsOfTravellerTVCell))
            }
        }
        
        if infantsCount != 0 {
            for i in 1...infantsCount {
                positionsCount += 1
                passengertypeArray.append("Infant")
                tablerow.append(TableRow(title:"Infant \(i)",key:"infant",headerText: "Master",characterLimit: positionsCount,cellType:.AddDeatilsOfTravellerTVCell))
            }
        }
        
        
        
        tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        
        tablerow.append(TableRow(cellType:.PromocodeTVCell))
        tablerow.append(TableRow(cellType:.PriceSummaryTVCell))
        tablerow.append(TableRow(title:"I Accept T&C and Privacy Policy",cellType:.AcceptTermsAndConditionTVCell))
        tablerow.append(TableRow(height:30, bgColor:.WhiteColor,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func setupRoundTripTVCells() {
        commonTableView.separatorStyle = .none
        tablerow.append(TableRow(key:"paynow",moreData: flightSummery, cellType:.RoundTripTVcell))
        
    }
    
    
    //MARK: - didTapOnFlightDetailsBtnAction
    override func didTapOnFlightDetailsBtnAction(cell:RoundTripTVcell){
        guard let vc = ViewFlightDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        self.present(vc, animated: true)
    }
    
    
    
    @objc func didTapOnViewHotelDetails(_ sender:UIButton) {
        guard let vc = ViewHotelDetails.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        self.present(vc, animated: true)
    }
    
    override func didTapOnLoginBtn(cell: TDetailsLoginTVCell) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.isvcFrom = "paynowvc"
        self.present(vc, animated: true)
    }
    
    //MARK: - didTapOnApplyBtn
    override func didTapOnApplyBtn(cell:PromocodeTVCell){
        
        
        if cell.promocodeTF.text?.isEmpty == false {
//            promoinfoArray.forEach { i in
//                if i.promo_code == cell.promocodeTF.text {
//                    callPromocodeAPI(promocodeStr: i.promo_code ?? "")
//                }else {
//                    promocodeBool = false
//                    //callPromocodeAPI(promocodeStr: i.promo_code ?? "")
//                }
//
//
//            }
            
            callPromocodeAPI(promocodeStr: cell.promocodeTF.text ?? "")
            
            
        }else {
            showToast(message: "Enter PromoCode To Apply")
        }
        
        
    }
    
    
    func callPromocodeAPI(promocodeStr:String) {
        payload.removeAll()
        payload["moduletype"] = "flight"
        payload["promocode"] = promocodeStr
        payload["total_amount_val"] = newpriceDetails?.grand_total ?? ""
        payload["convenience_fee"] = "0"
        payload["email"] = payemail
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        vm?.CALL_APPLY_PROMOCODE_API(dictParam: payload)
    }
    
    
    
    func promocodeResult(response: ApplyPromocodeModel) {
        
        if response.status == 1 {
            promocodeBool = true
            promocodeValue = response.total_amount_val ?? ""
            promocodeDiscountValue = response.value ?? ""
            promocodeString = response.promocode ?? ""
            grandTotal = "KWD:\(response.total_amount_val ?? "")"
            setuplabels(lbl: titlelbl, text: grandTotal, textcolor: .WhiteColor, font: .OpenSansMedium(size: 20), align: .left)
            NotificationCenter.default.post(name: NSNotification.Name("promocodeapply"), object: nil)
            
            DispatchQueue.main.async {[self] in
                commonTableView.reloadData()
            }
    
        }else {
            showToast(message: "Invalid Promo Code")
            promocodeBool = false
        }
        
    }
    
    
    
    
    override func didTapOnRefundBtn(cell: PriceSummaryTVCell) {
        print("didTapOnRefundBtn")
    }
    
    
    
    override func didTapOnCountryCodeBtn(cell: ContactInformationTVCell) {
        self.billingCountryCode = cell.billingCountryCode
        self.billingCountryName = cell.billingCountryName
        self.paycountryCode = cell.countryCodeLbl.text ?? ""
    }
    
    
    override func didTapOnDropDownBtn(cell: ContactInformationTVCell) {
        self.billingCountryCode = cell.billingCountryCode
        self.billingCountryName = cell.billingCountryName
        self.paycountryCode = cell.countryCodeLbl.text ?? ""
    }
    
    override func editingTextField(tf:UITextField){
        switch tf.tag {
        case 111:
            self.payemail = tf.text ?? ""
            break
            
        case 222:
            self.paymobile = tf.text ?? ""
            break
            
            
        default:
            break
        }
    }
    
    func goToSaveTravellersDetailsVC(ptitle:String,keyStr:String,id1:String) {
        guard let vc = SaveTravellersDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.ptitle = ptitle
        vc.keyStr = keyStr
        vc.id = id1
        self.present(vc, animated: true)
    }
    
    override func didTapOnTAndCAction(cell: AcceptTermsAndConditionTVCell) {
        gotoAboutUsVC(keystr: "terms")
    }
    
    override func didTapOnPrivacyPolicyAction(cell: AcceptTermsAndConditionTVCell) {
        gotoAboutUsVC(keystr: "aboutus")
    }
    
    func gotoAboutUsVC(keystr:String) {
        guard let vc = AboutUsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.keystr = keystr
        present(vc, animated: true)
    }
    
    
    // MARK: - AddDeatilsOfGuestTVCell Delegate Functions
    override func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfTravellerTVCell){
        if cell.expandViewBool == true {
            
            cell.expandView()
            cell.expandViewBool = false
        }else {
            
            cell.collapsView()
            cell.expandViewBool = true
        }
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    
    
    override func donedatePicker(cell:AddDeatilsOfTravellerTVCell){
        self.view.endEditing(true)
    }
    
    
    override func cancelDatePicker(cell:AddDeatilsOfTravellerTVCell){
        self.view.endEditing(true)
    }
    
    
    
    //MARK: - AddDeatilsOfGuestTVCell Delegate Methods
    override func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfGuestTVCell){
        if cell.expandViewBool == true {
            
            cell.expandView()
            cell.expandViewBool = false
        }else {
            
            cell.collapsView()
            cell.expandViewBool = true
        }
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    
    // MARK: - didTapOnBookNowBtn
    @objc func didTapOnBookNowBtn(_ sender:UIButton) {
        
        if keystr == "flight" {
            bookFlight()
        }else {
            bookHotel()
        }
    }
    
    
}


extension PayNowVC {
    
    
    
    func callAPI() {
        payload["search_id"] = searchid
        payload["booking_source"] = bookingsource
        payload["promocode_val"] = ""
        payload["access_key"] = accesskey
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        vm?.CALL_MOBILE_PRE_BOOKING_API(dictParam: payload)
    }
    
    
    func preBookingDetails(response: PreBookingModel) {
        
        promoinfoArray = response.promo_info ?? []
        tmpFlightPreBookingId = response.form_params?.booking_id ?? ""
        // tokenkey = response.form_params?.token_key ?? ""
        
        holderView.isHidden = false
        DispatchQueue.main.async {[self] in
            
            
            let seconds = 0.50
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                payload.removeAll()
                payload["search_id"] = searchid
                payload["booking_source"] = bookingsourcekey
                payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
                payload["promocode_val"] = ""
                payload["access_key"] = accesskey
                payload["booking_id"] = tmpFlightPreBookingId
                vm?.CALL_MOBILE_FLIGHT_BOOKING_API(dictParam: payload)
            }
        }
        
    }
    
    
    func flightBookingDetails(response: FlightBookingModel) {
        
        holderView.isHidden = false
        booknowHolderView.isHidden = false
        
        tokenkey = response.flight_data?[0].token_key ?? ""
        
        searchid = response.pre_booking_params?.search_id ?? ""
        activepaymentoptions = response.active_payment_options?[0] ?? ""
        flightSummery = response.flight_data?[0].flight_details?.summary ?? []
        
        
        DispatchQueue.main.async {[self] in
            setupTVCells()
        }
    }
    
}




extension PayNowVC {
    
    func addObserver() {
        
        self.view.backgroundColor = .WhiteColor
        holderView.backgroundColor = .AppHolderViewColor
        holderView.isHidden = true
        
        
        let logstatus = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus)
        if logstatus == true  {
            //            payemail = defaults.string(forKey: UserDefaultsKeys.useremail) ?? ""
            //            paymobile = defaults.string(forKey: UserDefaultsKeys.usermobile) ?? ""
            //            paycountryCode = defaults.string(forKey: UserDefaultsKeys.usermobilecode) ?? ""
            mobilenoMaxLengthBool = true
        }else {
            paycountryCode = "+965"
        }
        
        if keystr == "flight" {
            
            
            setuplabels(lbl: nav.titlelbl, text: defaults.string(forKey: UserDefaultsKeys.journyCitys) ?? "", textcolor: .AppLabelColor, font: .OpenSansBold(size: 14), align: .left)
            setuplabels(lbl: nav.citylbl, text: "\(defaults.string(forKey: UserDefaultsKeys.journyDates) ?? ""), \(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "")", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12), align: .left)
            
            
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
            
            
            
            booknowHolderView.isHidden = true
            if callapibool == true {
                DispatchQueue.main.async {[self] in
                    holderView.isHidden = true
                    callAPI()
                }
            }
            
        }else {
            
            if screenHeight > 835 {
                navHeight.constant = 200
            }else {
                navHeight.constant = 180
            }
            
            
            if callapibool == true {
                DispatchQueue.main.async {[self] in
                    holderView.isHidden = true
                    callHotelMobileBookingAPI()
                }
            }
        }
        
        TimerManager.shared.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cancelpromo), name: Notification.Name("cancelpromo"), object: nil)
        
    }
    
    
    
    @objc func cancelpromo() {
        promocodeBool = false
        promocodeValue = ""
        promocodeString = ""
        grandTotal = newGrandTotal
        setuplabels(lbl: titlelbl, text: grandTotal, textcolor: .WhiteColor, font: .oswaldRegular(size: 20), align: .left)

        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
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


//MARK: - setup Flight TVCells
extension PayNowVC {
    
    func bookFlight() {
        
        payload.removeAll()
        payload1.removeAll()
        
        
        var callpaymentbool = true
        var fnameCharBool = true
        var lnameCharBool = true
        
        
        for traveler in travelerArray {
            
            if traveler.firstName == nil  || traveler.firstName?.isEmpty == true{
                callpaymentbool = false
                
            }
            
            if (traveler.firstName?.count ?? 0) <= 3 {
                fnameCharBool = false
            }
            
            if traveler.lastName == nil || traveler.firstName?.isEmpty == true{
                callpaymentbool = false
            }
            
            if (traveler.lastName?.count ?? 0) <= 3 {
                lnameCharBool = false
            }
            
            if traveler.dob == nil || traveler.dob?.isEmpty == true{
                callpaymentbool = false
            }
            
            if traveler.passportno == nil || traveler.passportno?.isEmpty == true{
                callpaymentbool = false
            }
            
            if traveler.passportIssuingCountry == nil || traveler.passportIssuingCountry?.isEmpty == true{
                callpaymentbool = false
            }
            
            if traveler.passportExpireDate == nil || traveler.passportExpireDate?.isEmpty == true{
                callpaymentbool = false
            }
            
            
            // Continue checking other fields
        }
        
        
        
        
        // Create an array to store validation results for each cell
        var validationResults: [Bool] = []
        
        let positionsCount = commonTableView.numberOfRows(inSection: 0)
        for position in 0..<positionsCount {
            
            
            if let cell = commonTableView.cellForRow(at: IndexPath(row: position, section: 0)) as? AddDeatilsOfTravellerTVCell {
                
                var cellValidationResult = true
                
                if cell.titleTF.text?.isEmpty == true {
                    cell.titleView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                    cellValidationResult = false
                }
                
                if cell.fnameTF.text?.isEmpty == true {
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                    cellValidationResult = false
                } else if (cell.fnameTF.text?.count ?? 0) <= 3 {
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    fnameCharBool = false
                    cellValidationResult = false
                }
                
                if cell.lnameTF.text?.isEmpty == true {
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                    cellValidationResult = false
                } else if (cell.lnameTF.text?.count ?? 0) <= 3 {
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    lnameCharBool = false
                    cellValidationResult = false
                    
                }
                
                if cell.dobTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.dobView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                    cellValidationResult = false
                }
                
                
                if cell.passportnoTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.passportnoView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                    cellValidationResult = false
                }
                
                
                if cell.passportIssuingCountryTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.issuecountryView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                    cellValidationResult = false
                }
                
                
                if cell.passportExpireDateTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.passportexpireView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                    cellValidationResult = false
                }
                
                
                validationResults.append(cellValidationResult)
            }
        }
        
        
        let mrtitleArray = travelerArray.compactMap({$0.mrtitle})
        let laedpassengerArray = travelerArray.compactMap({$0.laedpassenger})
        let middlenameArray = travelerArray.compactMap({$0.middlename})
        let genderArray = travelerArray.compactMap({$0.gender})
        let firstnameArray = travelerArray.compactMap({$0.firstName})
        let lastNameArray = travelerArray.compactMap({$0.lastName})
        let dobArray = travelerArray.compactMap({$0.dob})
        let passportnoArray = travelerArray.compactMap({$0.passportno})
        let passportIssuingCountryArray = travelerArray.compactMap({$0.passportIssuingCountry})
        let passportExpireDateArray = travelerArray.compactMap({$0.passportExpireDate})
        //        let frequentFlyrNoArray = travelerArray.compactMap({$0.frequentFlyrNo})
        //        let mealNameArray = travelerArray.compactMap({$0.meal})
        //        let specialAssicintenceArray = travelerArray.compactMap({$0.specialAssicintence})
        //        let nationalityArray = travelerArray.compactMap({$0.nationality})
        
        
        // Convert arrays to string representations
        let laedpassengerString = "[\"" + laedpassengerArray.joined(separator: "\",\"") + "\"]"
        let genderString = "[\"" + genderArray.joined(separator: "\",\"") + "\"]"
        let mrtitleString = "[\"" + mrtitleArray.joined(separator: "\",\"") + "\"]"
        let firstnameString = "[\"" + firstnameArray.joined(separator: "\",\"") + "\"]"
        let middlenameString = "[\"" + middlenameArray.joined(separator: "\",\"") + "\"]"
        let lastNameString = "[\"" + lastNameArray.joined(separator: "\",\"") + "\"]"
        let dobString = "[\"" + dobArray.joined(separator: "\",\"") + "\"]"
        let passportnoString = "[\"" + passportnoArray.joined(separator: "\",\"") + "\"]"
        let passportIssuingCountryString = "[\"" + passportIssuingCountryArray.joined(separator: "\",\"") + "\"]"
        let passportExpireDateString = "[\"" + passportExpireDateArray.joined(separator: "\",\"") + "\"]"
        let passengertypeArrayString = "[\"" + passengertypeArray.joined(separator: "\",\"") + "\"]"
        
        
        payload["search_id"] = searchid
        payload["tmp_flight_pre_booking_id"] = tmpFlightPreBookingId
        payload["token_key"] = "\(tokenkey)"
        payload["access_key"] =  accesskey
        payload["access_key_tp"] =  accesskey
        payload["insurance_policy_type"] = "0"
        payload["insurance_policy_option"] = "0"
        payload["insurance_policy_cover_type"] = "0"
        payload["insurance_policy_duration"] = "0"
        payload["isInsurance"] = "0"
        payload["redeem_points_post"] = "1"
        payload["booking_source"] = bookingsourcekey
        payload["promocode_val"] = promocodeString
        payload["promocode_code"] = ""
        payload["mealsAmount"] = "0"
        payload["baggageAmount"] = "0"
        
        payload["passenger_type"] = passengertypeArrayString
        payload["lead_passenger"] = laedpassengerString
        payload["gender"] = genderString
        payload["name_title"] =  mrtitleString
        payload["first_name"] =  firstnameString
        payload["middle_name"] =  middlenameString
        payload["last_name"] =  lastNameString
        payload["date_of_birth"] =  dobString
        payload["passenger_passport_number"] =  passportnoString
        payload["passenger_passport_issuing_country"] =  passportIssuingCountryString
        payload["passenger_nationality"] = passportIssuingCountryString
        payload["passenger_passport_expiry"] =  passportExpireDateString
        
        
        
        
        payload["Frequent"] = "\([["Select"]])"
        payload["ff_no"] = "\([[""]])"
        payload["payment_method"] =  "PNHB1"
        
        payload["billing_email"] = email
        payload["passenger_contact"] = mobile
        payload["country_mobile_code"] = countryCode
        payload["insurance"] = "1"
        payload["tc"] = "on"
        payload["booking_step"] = "book"
        payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        payload["address2"] = ""
        payload["billing_address_1"] = ""
        payload["billing_state"] = ""
        payload["billing_city"] = ""
        payload["billing_zipcode"] = ""
        
        // Check additional conditions
        if callpaymentbool == false {
            showToast(message: "Add Details")
        }else if passportExpireDateBool == false {
            showToast(message: "Invalid expiry. Passport expires within the next 3 months.")
        }else if !fnameCharBool {
            showToast(message: "First name should have more than 3 characters")
        }else if !lnameCharBool {
            showToast(message: "Last name should have more than 3 characters")
        }else if payemail == "" {
            showToast(message: "Enter Email Address")
        }else if payemail.isValidEmail() == false {
            showToast(message: "Enter Valid Email Addreess")
        }else if paymobile == "" {
            showToast(message: "Enter Mobile No")
        }else if paycountryCode == "" {
            showToast(message: "Enter Country Code")
        }else if mobilenoMaxLengthBool == false {
            showToast(message: "Enter Valid Mobile No")
        }else if checkTermsAndCondationStatus == false {
            showToast(message: "Please Accept T&C and Privacy Policy")
        }else {
            vm?.CALL_PROCESS_PASSENGER_DETAIL_API(dictParam: payload, key: tmpFlightPreBookingId)
        }
        
    }
    
    
    func processPassengerDetails(response: ProcessPassangerDetailModel) {
        DispatchQueue.main.async {[self] in
            payload.removeAll()
            payload["app_reference"] = tmpFlightPreBookingId
            payload["search_id"] = searchid
            payload["promocode_val"] = promocodeString
            
            vm?.CALL_PRE_FLIGHT_BOOKING_API(dictParam: payload, key: searchid)
        }
    }
    
    
    func preFlightBookingDetails(response: ProcessPassangerDetailModel) {
        DispatchQueue.main.async {[self] in
            payload.removeAll()
            payload["app_reference"] = tmpFlightPreBookingId
            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            
            vm?.CALL_FLIGHT_PRE_CONF_PAYMENT_API(dictParam: payload, key: "\(searchid)")
        }
    }
    
    
    func flightPrePaymentDetails(response: sendToPaymentModel) {
        
        DispatchQueue.main.async {[self] in
            payload.removeAll()
            payload["extra_price"] = "0"
            payload["promocode_val"] = promocodeString
            
            vm?.CALL_SENDTO_PAYMENT_API(dictParam: payload, key: "\(tmpFlightPreBookingId)/\(searchid)")
        }
    }
    
    
    func sendtoPaymentDetails(response: sendToPaymentModel) {
        DispatchQueue.main.async {[self] in
            payload.removeAll()
            vm?.CALL_SECURE_BOOKING_API(dictParam: [:], key: "\(tmpFlightPreBookingId)")
        }
    }
    
    
    func secureBookingDetails(response: sendToPaymentModel) {
        securebooingbool = true
        if response.status == true {
            gotoLoadWebViewVC(url: response.form_url ?? "")
        }else {
            showToast(message: response.msg ?? "")
        }
    }
    
    func gotoLoadWebViewVC(url:String) {
        guard let vc = LoadWebViewVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.urlString = url
        vc.isVcFrom = "payment"
        present(vc, animated: true)
    }
    
}


//MARK: - setupHotelTVCells
extension PayNowVC {
    
    
    
    //MARK: - callHotelMobileBookingAPI
    func callHotelMobileBookingAPI() {
        payload.removeAll()
        payload["search_id"] = hsearch_id
        payload["booking_source"] = hbooking_source
        payload["token"] = htoken
        payload["token_key"] = htokenkey
        payload["rateKey"] = "[\"" + ratekeyArray.joined(separator: "\",\"") + "\"]"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        vm2?.CALL_GET_HOTEL_MOBILE_BOOKING_DETAILS_API(dictParam: payload)
    }
    
    
    //MARK: - hotelMBDetails
    func hotelMBDetails(response: HotelMBModel) {
        hoteldetails = response.data?.hotel_details
        holderView.isHidden = false
        hbookingToken = response.data?.token ?? ""
        hcurrency = response.data?.currency_obj?.to_currency ?? ""
        
        nav.titlelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "")"
        nav.citylbl.text = "CheckIn -\(defaults.string(forKey: UserDefaultsKeys.checkin) ?? "" ) CheckOut -\(defaults.string(forKey: UserDefaultsKeys.checkout) ?? "")"
        
        nav.datelbl.text = "Guests- \(defaults.string(forKey: UserDefaultsKeys.guestcount) ?? "") / Room - \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "")"
        
        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "1") ?? 0
        childCount = Int(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "0") ?? 0
        
        DispatchQueue.main.async {[self] in
            setupHotelTVCells()
        }
    }
    
    
    //MARK: - setupHotelTVCells
    func setupHotelTVCells() {
        tablerow.removeAll()
        holderView.isHidden = false
        
        tablerow.append(TableRow(title:hoteldetails?.name,
                                 subTitle: hoteldetails?.address,
                                 text: "",
                                 buttonTitle: String(hoteldetails?.hotel_code ?? 0),
                                 image: hoteldetails?.image,
                                 tempText: "Refundable",
                                 characterLimit: hoteldetails?.star_rating,
                                 cellType:.HotelSearchResultTVCell))
        
        
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
            tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
        }
        
        
        
        
        tablerow.append(TableRow(title:"Guest Details",cellType:.TotalNoofTravellerTVCell))
        
        for i in 1...adultsCount {
            positionsCount += 1
            let travellerCell = TableRow(title: "Adult \(i)", key: "adult", characterLimit: positionsCount, cellType: .AddDeatilsOfGuestTVCell)
            
            tablerow.append(travellerCell)
            
        }
        
        
        if childCount != 0 {
            for i in 1...childCount {
                positionsCount += 1
                tablerow.append(TableRow(title:"Child \(i)",key:"child",characterLimit: positionsCount,cellType:.AddDeatilsOfGuestTVCell))
                
            }
        }
        
        
        tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        tablerow.append(TableRow(cellType:.PromocodeTVCell))
        tablerow.append(TableRow(title:"Purchase Summary",
                                 subTitle: defaults.string(forKey: UserDefaultsKeys.roomType),
                                 key:defaults.string(forKey: UserDefaultsKeys.checkout),
                                 text: defaults.string(forKey: UserDefaultsKeys.hoteladultscount),
                                 headerText: defaults.string(forKey: UserDefaultsKeys.hoteladultscount),
                                 buttonTitle: defaults.string(forKey: UserDefaultsKeys.checkin),
                                 key1: defaults.string(forKey: UserDefaultsKeys.refundtype),
                                 questionType: "KWD:30.00",
                                 TotalQuestions:grandTotal,
                                 cellType:.HotelPurchaseSummaryTVCell,
                                 questionBase: grandTotal))
        tablerow.append(TableRow(title:"I Accept T&C and Privacy Policy",cellType:.AcceptTermsAndConditionTVCell))
        tablerow.append(TableRow(height:30, bgColor:.AppHolderViewColor,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    func bookHotel() {
        
        payload.removeAll()
        payload1.removeAll()
        
        
        var callpaymenthotelbool = true
        var fnameCharBool = true
        var lnameCharBool = true
        
        
        for traveler in travelerArray {
            
            if traveler.firstName == nil  || traveler.firstName?.isEmpty == true{
                callpaymenthotelbool = false
                
            }
            
            if (traveler.firstName?.count ?? 0) <= 3 {
                fnameCharBool = false
            }
            
            if traveler.lastName == nil || traveler.firstName?.isEmpty == true{
                callpaymenthotelbool = false
            }
            
            if (traveler.lastName?.count ?? 0) <= 3 {
                lnameCharBool = false
            }
            
            
            // Continue checking other fields
        }
        
        
        
        let positionsCount = commonTableView.numberOfRows(inSection: 0)
        for position in 0..<positionsCount {
            // Fetch the cell for the given position
            if let cell = commonTableView.cellForRow(at: IndexPath(row: position, section: 0)) as? AddDeatilsOfGuestTVCell {
                
                if cell.titleTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.titleView.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                    
                }
                
                if cell.fnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                }else if (cell.fnameTF.text?.count ?? 0) <= 3{
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    fnameCharBool = false
                }else {
                    fnameCharBool = true
                }
                
                if cell.lnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                }else if (cell.lnameTF.text?.count ?? 0) <= 3{
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    lnameCharBool = false
                } else {
                    // Textfield is not empty
                    lnameCharBool = true
                }
                
                
            }
        }
        
        
        let mrtitleArray = travelerArray.compactMap({$0.mrtitle})
        let passengertypeArray = travelerArray.compactMap({$0.passengertype})
        let firstnameArray = travelerArray.compactMap({$0.firstName})
        let lastNameArray = travelerArray.compactMap({$0.lastName})
        let laedpassengerArray = travelerArray.compactMap({$0.laedpassenger})
        
        let mrtitleString = "[\"" + mrtitleArray.joined(separator: "\",\"") + "\"]"
        let firstnameString = "[\"" + firstnameArray.joined(separator: "\",\"") + "\"]"
        let lastNameString = "[\"" + lastNameArray.joined(separator: "\",\"") + "\"]"
        let passengertypeString = "[\"" + passengertypeArray.joined(separator: "\",\"") + "\"]"
        let laedpassengerArrayString = "[\"" + laedpassengerArray.joined(separator: "\",\"") + "\"]"
        
        
        payload["search_id"] = hsearch_id
        payload["token"] = hbookingToken
        payload["token_key"] = hbookingToken
        payload["booking_source"] = hbooking_source
        payload["payment_method"] = "PNHB1"
        payload["payment_booking_source"] = ""
        payload["promo_code"] = ""
        payload["promo_actual_value"] = ""
        payload["base_en_rate"] = ""
        payload["reward_usable"] = ""
        payload["reward_earned"] = ""
        payload["total_price_with_rewards"] = ""
        payload["reducing_amount"] = ""
        payload["passenger_type"] = passengertypeString
        payload["lead_passenger"] = laedpassengerArrayString
        payload["rateKey"] = ""
        payload["mealsID"] = ""
        payload["dob"] = "\([""])"
        payload["nationality"] = "\([""])"
        payload["name_title"] = mrtitleString
        payload["first_name"] = firstnameString
        payload["last_name"] = lastNameString
        payload["billing_email"] = email
        payload["passenger_contact"] = mobile
        payload["special_req"] = "\([""])"
        payload["payment_value"] = "payment_gateway_knet"
        payload["users_comments"] = ""
        
        
        // Check additional conditions
        if email == "" {
            showToast(message: "Enter Email Address")
        }else if email.isValidEmail() == false {
            showToast(message: "Enter Valid Email Addreess")
        }else if mobile == "" {
            showToast(message: "Enter Mobile No")
        }else if countryCode == "" {
            showToast(message: "Enter Country Code")
        }else if mobilenoMaxLengthBool == false {
            showToast(message: "Enter Valid Mobile No")
        }else
        
        if callpaymenthotelbool == false{
            showToast(message: "Add Details")
        }else if fnameCharBool == false{
            showToast(message: "More Than 3 Char")
        }else if lnameCharBool == false{
            showToast(message: "More Than 3 Char")
        }else if checkTermsAndCondationStatus == false {
            showToast(message: "Please Accept T&C and Privacy Policy")
        }else {
            
            print(payload)
            
            vm2?.CALL_GET_HOTEL_MOBILE_PRE_BOOKING_DETAILS_API(dictParam: payload)
        }
        
    }
    
    
    func hotelMobilePreBookingDetails(response: HMPreBookingModel) {
        BASE_URL = ""
        payload.removeAll()
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        vm2?.CALL_GET_HOTEL_SECURE_BOOKING_API(dictParam: payload, urlstr: response.data?.post_data?.url ?? "")
    }
    
    
    func hotelSecureBookingDetails(response: HotelSecureBookingModel) {
        BASE_URL = BASE_URL1
    }
    
    
}
