//
//  PayNowVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 18/08/22.
//

import UIKit
import CoreData

class PayNowVC: BaseTableVC, PreBookingViewModelDelegate,GetCountryListViewModelDelegate, HotelMBViewModelDelegate, TimerManagerDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    @IBOutlet weak var booknowHolderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    
    
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
    var vm1:GetCountryListViewModel?
    var vm2:HotelMBViewModel?
    var flightSummery = [Summary] ()
    var hoteldetails : HotelMBHotelDetails?
    var hcurrency = String()
    var securebooingbool = false
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        fetchCoreDataValues()
        if keystr == "flight" {
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
            
            
            NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name(rawValue: "reload"), object: nil)
            
            booknowHolderView.isHidden = true
            if callapibool == true {
                DispatchQueue.main.async {[self] in
                    holderView.isHidden = true
                    callGetCountryListAPI()
                }
            }
            
        }else {
            adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "1") ?? 0
            childCount = Int(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "0") ?? 0
            
            
            if callapibool == true {
                DispatchQueue.main.async {[self] in
                    holderView.isHidden = true
                    callGetCountryListAPI()
                }
            }
        }
        
        TimerManager.shared.delegate = self
    }
    
    func timerDidFinish() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func updateTimer() {
        
    }
    
    func callGetCountryListAPI() {
        vm1?.CALL_GET_COUNTRY_LIST_API(dictParam: [:])
    }
    
    
    func countryList(response: GetCountryListModel) {
        countrylist = response.data?.country_list ?? []
        
        DispatchQueue.main.async {[self] in
            
            if keystr == "flight" {
                holderView.isHidden = true
                callAPI()
            }else {
                callHotelMobileBookingAPI()
            }
        }
    }
    
    
    func callAPI() {
        payload["search_id"] = searchid
        payload["booking_source"] = bookingsource
        payload["promocode_val"] = ""
        payload["access_key"] = accesskey
        vm?.CALL_MOBILE_PRE_BOOKING_API(dictParam: payload)
    }
    
    
    func preBookingDetails(response: PreBookingModel) {
        tmpFlightPreBookingId = response.form_params?.booking_id ?? ""
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
                vm?.CALL_MOBILE_FLIGHT_BOOKING_API(dictParam: payload)
            }
        }
        
    }
    
    
    func flightBookingDetails(response: FlightBookingModel) {
        
        holderView.isHidden = false
        booknowHolderView.isHidden = false
        searchid = response.pre_booking_params?.search_id ?? ""
        tokenkey = response.form_params?.token_key ?? ""
        accesskey = response.access_key_tp ?? ""
        activepaymentoptions = response.active_payment_options?[0] ?? ""
        flightSummery = response.flight_data?[0].flight_details?.summary ?? []
        
        DispatchQueue.main.async {[self] in
            setupTVCells()
        }
    }
    
    @objc func reload(notification:NSNotification) {
        commonTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .WhiteColor
        holderView.backgroundColor = .AppHolderViewColor
        holderView.isHidden = true
        vm = PreBookingViewModel(self)
        vm1 = GetCountryListViewModel(self)
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
        
        
        if keystr == "flight" {
            
            setuplabels(lbl: nav.titlelbl, text: defaults.string(forKey: UserDefaultsKeys.journyCitys) ?? "", textcolor: .AppLabelColor, font: .OpenSansBold(size: 14), align: .left)
            setuplabels(lbl: nav.citylbl, text: "\(defaults.string(forKey: UserDefaultsKeys.journyDates) ?? ""), \(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "")", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12), align: .left)
            
            
            
        }else {
            
            nav.titlelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "")"
            nav.citylbl.text = "CheckIn -\(defaults.string(forKey: UserDefaultsKeys.checkin) ?? "" ) CheckOut -\(defaults.string(forKey: UserDefaultsKeys.checkout) ?? "")"
            
            nav.datelbl.text = "Guests-1 \(defaults.string(forKey: UserDefaultsKeys.guestcount) ?? "")/ Room - \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "")"
            
            
            if screenHeight > 835 {
                navHeight.constant = 200
            }else {
                navHeight.constant = 180
            }
            
            
        }
        
        commonTableView.registerTVCells(["TDetailsLoginTVCell",
                                         "EmptyTVCell",
                                         "PromocodeTVCell",
                                         "PriceSummaryTVCell",
                                         "HotelPurchaseSummaryTVCell",
                                         "checkOptionsTVCell",
                                         "AddTravellersDetailsTVCell",
                                         "PriceLabelsTVCell",
                                         "AddAdultTravellerTVCell",
                                         "AddChildTravellerTVCell",
                                         "ContactInformationTVCell",
                                         "AcceptTermsAndConditionTVCell",
                                         "RoundTripTVcell",
                                         "HotelSearchResultTVCell",
                                         "AddInfantaTravellerTVCell"])
        
        
        
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
        
        tablerow.append(TableRow(title:"Passenger Details",subTitle: String(adultsCount),buttonTitle: String(childCount),tempText: String(infantsCount),cellType:.AddAdultTravellerTVCell))
        if childCount != 0 {
            tablerow.append(TableRow(cellType:.AddChildTravellerTVCell))
        }
        if infantsCount != 0 {
            tablerow.append(TableRow(cellType:.AddInfantaTravellerTVCell))
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
        self.present(vc, animated: true)
    }
    
    override func didTapOnApplyBtn(cell:PromocodeTVCell){
        print("didTapOnApplyBtn")
    }
    
    
    
    override func didTapOnRefundBtn(cell: PriceSummaryTVCell) {
        print("didTapOnRefundBtn")
    }
    
    override func didTapOnAddAdultBtn(cell: AddAdultTravellerTVCell) {
        ageCategory = AgeCategory.adult
        goToSaveTravellersDetailsVC(ptitle: "Adult", keyStr: "add", id1: "")
    }
    
    override func didTapOnAddChildBtn(cell: AddChildTravellerTVCell) {
        ageCategory = AgeCategory.child
        goToSaveTravellersDetailsVC(ptitle: "Child", keyStr: "add", id1: "")
    }
    
    override func didTapOnAddInfantaBtn(cell: AddInfantaTravellerTVCell) {
        ageCategory = AgeCategory.infant
        goToSaveTravellersDetailsVC(ptitle: "Infanta", keyStr: "add", id1: "")
    }
    
    override func didTapOnEditTraveller(cell: AddAdultsOrGuestTVCell) {
        goToSaveTravellersDetailsVC(ptitle: cell.passengerType, keyStr: "edit", id1: cell.travellerId)
    }
    
    override func didTapOndeleteTravellerBtnAction(cell: AddAdultsOrGuestTVCell) {
        //goToSaveTravellersDetailsVC(ptitle: "Infantas")
    }
    
    override func didTapOnSelectAdultTraveller(Cell: AddAdultsOrGuestTVCell) {
        
    }
    
    override func didTapOnCountryCodeBtn(cell: ContactInformationTVCell) {
        self.billingCountryCode = cell.billingCountryCode
        self.billingCountryName = cell.billingCountryName
        self.countryCode = cell.countryCodeLbl.text ?? ""
    }
    
    
    override func didTapOnDropDownBtn(cell: ContactInformationTVCell) {
        self.billingCountryCode = cell.billingCountryCode
        self.billingCountryName = cell.billingCountryName
        self.countryCode = cell.countryCodeLbl.text ?? ""
    }
    
    override func editingTextField(tf:UITextField){
        switch tf.tag {
        case 111:
            self.email = tf.text ?? ""
            break
            
        case 222:
            self.mobile = tf.text ?? ""
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
    
    
    @objc func didTapOnBookNowBtn(_ sender:UIButton) {
        
        if keystr == "flight" {
            bookFlight()
        }else {
            bookHotel()
        }
    }
    
    
    
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchCoreDataValues() {
        
        fnameA.removeAll()
        passengertypeA.removeAll()
        title2A.removeAll()
        dobA.removeAll()
        passportNoA.removeAll()
        genderA.removeAll()
        lnameA.removeAll()
        passportexpiryA.removeAll()
        passportissuingcountryA.removeAll()
        middleNameA.removeAll()
        leadPassengerA.removeAll()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        //request.predicate = NSPredicate(format: "age = %@", "21")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            
            details = result
            print(details)
            
            for data in result as! [NSManagedObject]{
                
                genderA.append((data.value(forKey: "gender") as? String) ?? "")
                fnameA.append((data.value(forKey: "fname") as? String) ?? "")
                lnameA.append((data.value(forKey: "lname") as? String) ?? "")
                middleNameA.append("")
                passengertypeA.append((data.value(forKey: "passengerType") as? String) ?? "")
                title2A.append((data.value(forKey: "nameTitle") as? String) ?? "")
                dobA.append((data.value(forKey: "dob") as? String) ?? "")
                passportNoA.append((data.value(forKey: "passportno") as? String) ?? "")
                passportexpiryA.append((data.value(forKey: "passportexpirydate") as? String) ?? "")
                passportissuingcountryA.append((data.value(forKey: "issuingCountryCode") as? String) ?? "")
                leadPassengerA.append("1")
                
            
            }
            
            
        } catch {
            print("Failed")
        }
    }
    
    
    
    
    
}



extension PayNowVC {
    
    func bookFlight() {
        
        payload.removeAll()
        payload1.removeAll()
        
        
        payload["search_id"] = searchid
        payload["tmp_flight_pre_booking_id"] = tmpFlightPreBookingId
        payload["token_key"] = tokenkey
        payload["access_key"] =  accesskey
        payload["insurance_policy_type"] = "0"
        payload["insurance_policy_option"] = "0"
        payload["insurance_policy_cover_type"] = "0"
        payload["insurance_policy_duration"] = "0"
        payload["isInsurance"] = "0"
        payload["redeem_points_post"] = "1"
        payload["booking_source"] = bookingsourcekey
        payload["promocode_val"] = ""
        payload["promocode_code"] = ""
        payload["mealsAmount"] = "0"
        payload["baggageAmount"] = "0"
        
        
        payload["passenger_type"] = passengertypeA
        payload["lead_passenger"] = leadPassengerA
        payload["gender"] = genderA
        payload["passenger_nationality"] = passportissuingcountryA
        payload["name_title"] = title2A
        payload["first_name"] = fnameA
        payload["middle_name"] = middleNameA
        payload["last_name"] = lnameA
        payload["date_of_birth"] = dobA
        payload["passenger_passport_number"] = passportNoA
        payload["passenger_passport_issuing_country"] = passportissuingcountryA
        payload["passenger_passport_expiry"] = passportexpiryA
        payload["Frequent"] = [["Select"]]
        payload["ff_no"] = [[""]]
        
        payload["address2"] = "ecity"
        payload["billing_address_1"] = "DA"
        payload["billing_state"] = "ASDAS"
        payload["billing_city"] = "sdfsd"
        payload["billing_zipcode"] = "sdf"
        payload["billing_email"] = self.email
        payload["passenger_contact"] = self.mobile
        payload["billing_country"] = self.billingCountryName
        payload["country_mobile_code"] = self.billingCountryCode
        payload["insurance"] = "1"
        payload["tc"] = "on"
        payload["booking_step"] = "book"
        payload["payment_method"] = activepaymentoptions
        payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        
        
        if fnameA.count != Int(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1"){
            showToast(message: "Add Traveller Details")
        }else {
            CALL_PRE_PROCESS_PASSENGER_DETAIL_API()
        }
        
        
        
    }
    
    
    
    //MARK:  Call mobile process passenger Details API
    func CALL_PRE_PROCESS_PASSENGER_DETAIL_API(){
        
        
        if self.email == "" {
            showToast(message: "Enter Email Address")
        }else if self.email.isValidEmail() == false {
            showToast(message: "Enter Valid Email Addreess")
        }else if self.mobile == "" {
            showToast(message: "Enter Mobile No")
        }else if self.mobile.isValidMobileNumber() == false {
            showToast(message: "Enter Valid Mobile No")
        }else if self.billingCountryCode == "" {
            showToast(message: "Enter Country Code")
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
            payload["promocode_val"] = ""
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
            payload["promocode_val"] = ""
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


extension PayNowVC {
    
    
    
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
        
        
        
        
        tablerow.append(TableRow(title:"Guests Details",subTitle: String(adultsCount),buttonTitle: String(childCount),tempText: String(infantsCount),cellType:.AddAdultTravellerTVCell))
        if childCount != 0 {
            tablerow.append(TableRow(cellType:.AddChildTravellerTVCell))
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
                                 questionBase: "KWD:150.00"))
        tablerow.append(TableRow(title:"I Accept T&C and Privacy Policy",cellType:.AcceptTermsAndConditionTVCell))
        tablerow.append(TableRow(height:30, bgColor:.AppHolderViewColor,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    //MARK: - callHotelMobileBookingAPI
    func callHotelMobileBookingAPI() {
        payload.removeAll()
        payload["search_id"] = hsearch_id
        payload["booking_source"] = hbooking_source
        payload["token"] = htoken
        payload["token_key"] = htokenkey
        payload["rateKey"] = ratekeyArray
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        vm2?.CALL_GET_HOTEL_MOBILE_BOOKING_DETAILS_API(dictParam: payload)
    }
    
    
    //MARK: - hotelMBDetails
    func hotelMBDetails(response: HotelMBModel) {
        hoteldetails = response.data?.hotel_details
        holderView.isHidden = false
        hbookingToken = response.data?.token ?? ""
        hcurrency = response.data?.currency_obj?.to_currency ?? ""
        
        DispatchQueue.main.async {[self] in
            setupHotelTVCells()
        }
    }
    
    func bookHotel() {
        
        payload.removeAll()
        payload1.removeAll()
        
        
        
        payload["booking_source"] = hbooking_source
        payload["promo_code"] = ""
        payload["token"] = hbookingToken
        payload["redeem_points_post"] = "0"
        payload["reducing_amount"] = "0"
        payload["reward_usable"] = "0"
        payload["reward_earned"] = "0"
        payload["billing_email"] = self.email
        payload["passenger_contact"] = self.mobile
        payload["first_name"] = fnameA
        payload["last_name"] = lnameA
        payload["name_title"] = title2A
        payload["billing_country"] = self.billingCountryCode
        payload["country_code"] = self.countryCode
        payload["passenger_type"] = passengertypeA
        
        if passengerA.count != Int(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1"){
            showToast(message: "Select Traveller Details")
        }else if self.email == "" {
            showToast(message: "Enter Email Address")
        }else if self.email.isValidEmail() == false {
            showToast(message: "Enter Valid Email Addreess")
        }else if self.mobile == "" {
            showToast(message: "Enter Mobile No")
        }else if self.mobile.isValidMobileNumber() == false {
            showToast(message: "Enter Valid Mobile No")
        }else if self.billingCountryCode == "" {
            showToast(message: "Enter Country Code")
        }else if checkTermsAndCondationStatus == false {
            showToast(message: "Please Accept T&C and Privacy Policy")
        }else {
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



