//
//  HotelSearchResultVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//

import UIKit

class HotelSearchResultVC: BaseTableVC, HotelListViewModelDelegate, TimerManagerDelegate {
    
    
    
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var sessionlbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    
    
    
    var bookingSourceDataArrayCount = Int()
    var bookingSourceDataArray = [BookingSourceData]()
    var isFetchingData = false
    var nationalityCode = String()
    var isSearchBool = false
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var isVcFrom = String()
    var tablerow = [TableRow]()
    var hotelSearchResultArray = [HotelSearchResult]()
    var filtered = [HotelSearchResult]()
    var viewModel:HotelListViewModel?
    
    static var newInstance: HotelSearchResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HotelSearchResultVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        viewModel = HotelListViewModel(self)
        
        
    }
    
    func setupUI() {
        
        self.view.backgroundColor = .WhiteColor
        self.holderView.backgroundColor = .AppHolderViewColor
        nav.citylbl.isHidden = false
        nav.datelbl.isHidden = false
        nav.titlelbl.isHidden = false
        
        nav.editView.isHidden = false
        nav.editView.backgroundColor = .layoverColor
        
        nav.filterView.isHidden = false
        nav.filterView.backgroundColor = .layoverColor
        nav.filterImg.image = UIImage(named: "locc1")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        nav.filterBtn.addTarget(self, action: #selector(didTapOnViewMapBtnAction(_:)), for: .touchUpInside)
        
        nav.backBtn.addTarget(self, action: #selector(backbtnAction(_:)), for: .touchUpInside)
        nav.editBtn.addTarget(self, action: #selector(modifySearchHotel(_:)), for: .touchUpInside)
        
        
        
        let screenHeight = UIScreen.main.bounds.size.height
        if screenHeight > 835 {
            navHeight.constant = 180
        }else {
            navHeight.constant = 180
        }
        subtitlelbl.text = ""
        
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "HotelSearchResultTVCell"])
        
    }
    
    
    
    @objc func modifySearchHotel(_ sender:UIButton) {
        guard let vc = ModifyHotelSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    @objc func backbtnAction(_ sender:UIButton) {
        TimerManager.shared.sessionStop()
        guard let vc = BookHotelVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    @objc func didTapOnViewMapBtnAction(_ sender:UIButton) {
        guard let vc = MapViewVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    @IBAction func didTapOnFilterBtnAction(_ sender: Any) {
        guard let vc = FilterSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        vc.filterTapKey = "sort"
        self.present(vc, animated: false)
    }
    
    
}



//MARK: - callGetActiveSourceBookingSourchAPI CALL_HOTEL_SEARCH_API CALL_GET_HOTEL_LIST_API
extension HotelSearchResultVC {
    
    
    func callGetActiveSourceBookingSourchAPI() {
        viewModel?.CALL_GET_ACTIVE_BOOKINGSOURCE_API(dictParam: [:])
    }
    
    func getActiveBookingSourceResponse(response: ActiveBookingSourceModel) {
        // hbooking_source = response.data?[0].source_id ?? ""
        bookingSourceDataArray = response.data ?? []
        bookingSourceDataArrayCount = bookingSourceDataArray.count
        
        
        DispatchQueue.main.async {
            self.CallAPI()
        }
    }
    
    
    func CallAPI() {
        
        
        do {
            
            let arrJson = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            let theJSONText = NSString(data: arrJson, encoding: String.Encoding.utf8.rawValue)
            print(theJSONText ?? "")
            payload1["search_params"] = theJSONText
            viewModel?.CALL_HOTEL_SEARCH_API(dictParam: payload1)
            
        }catch let error as NSError{
            print(error.description)
        }
        
    }
    
    
    func hotelSearchresponse(response: HotelSearchModel) {
        
        
        // hbooking_source = response.boo ?? ""
        hsearch_id = String(response.search_id ?? 0)
        
        nav.titlelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "")"
        nav.citylbl.text = "CheckIn -\(defaults.string(forKey: UserDefaultsKeys.checkin) ?? "" ) CheckOut -\(defaults.string(forKey: UserDefaultsKeys.checkout) ?? "")"
        
        nav.datelbl.text = "Guests- \(defaults.string(forKey: UserDefaultsKeys.guestcount) ?? "") / Room - \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "")"
        
        
        DispatchQueue.main.async {
            self.callGetHotelListAPI()
        }
        
    }
    
    
    func callGetHotelListAPI() {
        
        
        //        bookingSourceDataArray.forEach { i in
        //
        //            let seconds = 1.0
        //            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
        //                callgetHotelListAPI(bs: i.source_id ?? "")
        //            }
        //        }
        
        callgetHotelListAPI(bs: "PTBSID0000000089")
        
    }
    
    
    func callgetHotelListAPI(bs:String) {
        payload.removeAll()
        payload["offset"] = "0"
        payload["limit"] = "10"
        payload["booking_source"] = bs
        payload["search_id"] = hsearch_id
        
        viewModel?.CALL_GET_HOTEL_LIST_API(dictParam: payload)
    }
    
    
    
    func hotelList(response: HotelListModel) {
        
        bookingSourceDataArrayCount -= 1
        
        
        isfilterApplied = false
        //    hotelSearchResultArray = response.data?.hotelSearchResult ?? []
        
        
        // Stop the timer if it's running
        TimerManager.shared.stopTimer()
        TimerManager.shared.startTimer(time: 900) // Set your desired total time
        
        
        
        if let newResults = response.data?.hotelSearchResult, !newResults.isEmpty {
            // Append the new data to the existing data
            hotelSearchResultArray.append(contentsOf: newResults)
            
        } else {
            // No more items to load, update UI accordingly
            print("No more items to load.")
            // You can show a message or hide a loading indicator here
        }
        
        
        //        if bookingSourceDataArrayCount == 0 {
        //
        //            holderView.isHidden = true
        //            if hotelSearchResultArray.count <= 0 {
        //                gotoNoInternetScreen(keystr: "noresult")
        //                // holderView.isHidden = true
        //            }else {
        //                DispatchQueue.main.async {
        //                    self.appendValues(list: self.hotelSearchResultArray)
        //                }
        //            }
        //        }
        
        
        DispatchQueue.main.async {
            self.appendValues(list: self.hotelSearchResultArray)
        }
        
    }
    
    
    
    func appendValues(list:[HotelSearchResult]) {
        
        
        prices.removeAll()
        nearBylocationsArray.removeAll()
        faretypeArray .removeAll()
        facilityArray.removeAll()
        mapModelArray.removeAll()
        
        
        list.forEach { i in
            
            if let price = i.price, !price.isEmpty {
                prices.append("\(price)")
            }
            
            if let hotelLocation = i.location, !hotelLocation.isEmpty {
                nearBylocationsArray.append(hotelLocation)
            }
            
            if let refund = i.refund, !refund.isEmpty {
                faretypeArray.append(refund)
            }
            
            
            
            i.facility?.forEach { j in
                if let facilityName = j.name, !facilityName.isEmpty {
                    facilityArray.append(facilityName)
                }
            }
        }
        
        prices = Array(Set(prices))
        nearBylocationsArray = Array(Set(nearBylocationsArray))
        faretypeArray = Array(Set(faretypeArray))
        facilityArray = Array(Set(facilityArray))
        
        
        list.forEach { i in
            let mapModel = MapModel(
                longitude: i.longitude ?? "",
                latitude: i.latitude ?? "",
                hotelname: i.name ?? ""
            )
            mapModelArray.append(mapModel)
        }
        
        
        DispatchQueue.main.async {
            self.setupTVCells(hotelList: list)
        }
        
    }
    
    
    
    
    func setupTVCells(hotelList:[HotelSearchResult]) {
        
        holderView.isHidden = false
        
        if hotelList.count == 0 {
            tablerow.removeAll()
            subtitlelbl.isHidden = true
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }else {
            tablerow.removeAll()
            subtitlelbl.isHidden = false
            setupLabels(lbl: subtitlelbl, text: "\(hotelList.count) Hotels Found", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12))
            hotelList.forEach { i in
                tablerow.append(TableRow(title:i.name,
                                         subTitle: "\(i.address ?? "")",
                                         kwdprice: "\(i.currency ?? "") \(i.price ?? "")",
                                         text: "\(i.hotel_code ?? "")",
                                         headerText: i.hotel_code,
                                         buttonTitle: i.booking_source,
                                         image: i.image,
                                         tempText:i.refund,
                                         characterLimit: i.star_rating,
                                         cellType:.HotelSearchResultTVCell))
                
            }
            
            tablerow.append(TableRow(height:50,
                                     bgColor: .AppHolderViewColor,
                                     cellType:.EmptyTVCell))
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
        
    }
}


//MARK: - callHotelSearchPaginationAPI
extension HotelSearchResultVC {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        
        if indexPath.row == lastRowIndex && !isFetchingData && isfilterApplied == false {
            
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.callHotelSearchPaginationAPI()
            }
        }
        
    }
    
    
    func callHotelSearchPaginationAPI() {
        
        guard !isFetchingData else {
            return // Don't make another API call if one is already in progress
        }
        
        print("You've reached the last cell, trigger the API call.")
        isFetchingData = true
        
        payload.removeAll()
        payload["search_id"] = hsearch_id
        payload["no_of_nights"] = "1"
        payload["offset"] = "50"
        payload["limit"] = "10"
        
        viewModel?.CALL_HOTEL_SEARCH_PAGENATION_API(dictParam: payload)
        
    }
    
    
    func hotelPaginationList(response: HotelListModel) {
        
        isFetchingData = false // Reset the flag after API response
        
        if let newResults = response.data?.hotelSearchResult, !newResults.isEmpty {
            // Append the new data to the existing data
            hotelSearchResultArray.append(contentsOf: newResults)
            
            DispatchQueue.main.async {
                self.appendValues(list: self.hotelSearchResultArray)
            }
        } else {
            // No more items to load, update UI accordingly
            print("No more items to load.")
            // You can show a message or hide a loading indicator here
        }
    }
    
}




//MARK: - Hotel Filters
extension HotelSearchResultVC:AppliedFilters {
    
    
    func hotelFilterByApplied(minpricerange: Double, maxpricerange: Double, starRating: String, refundableTypeArray: [String], nearByLocA: [String], niberhoodA: [String], aminitiesA: [String]) {
        
        
        isSearchBool = true
        isfilterApplied = true
        
        print("====minpricerange ==== \(minpricerange)")
        print("====maxpricerange ==== \(maxpricerange)")
        print(" ==== starRating === \(starRating)")
        print(" ==== refundableTypeArray === \n\(refundableTypeArray)")
        print(" ==== nearByLocA === \n\(nearByLocA)")
        print(" ==== aminitiesA === \n\(aminitiesA)")
        
        
        let filteredArray = hotelSearchResultArray.filter { hotel in
            guard let netPrice = Double(hotel.price ?? "0.0") else { return false }
            
            let ratingMatches = hotel.star_rating == Int(starRating) || starRating.isEmpty
            let refundableMatch = refundableTypeArray.isEmpty || refundableTypeArray.contains(hotel.refund ?? "")
            let nearByLocMatch = nearByLocA.isEmpty || nearByLocA.contains(hotel.location ?? "")
            
            
            let facilityMatch = aminitiesA.isEmpty || aminitiesA.allSatisfy { desiredAmenity in
                hotel.facility?.contains { facility in
                    let facilityName = facility.name?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
                    return facilityName == desiredAmenity.lowercased()
                } ?? false
            }
            
            
            return ratingMatches && netPrice >= minpricerange && netPrice <= maxpricerange && facilityMatch && nearByLocMatch && refundableMatch
            
            
        }
        
        
        filtered = filteredArray
        if filtered.count == 0{
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
        }else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
        }
        
        DispatchQueue.main.async {[self] in
            setupTVCells(hotelList: filtered)
        }
    }
    
    
    
    func filtersSortByApplied(sortBy: SortParameter) {
        
        switch sortBy {
        case .PriceLow:
            
            let sortedByPriceLowToHigh = hotelSearchResultArray.sorted { hotel1, hotel2 in
                return (Double(hotel1.price ?? "0.0") ?? 0.0 ) < (Double(hotel2.price ?? "0.0") ?? 0.0 )
            }
            
            setupTVCells(hotelList: sortedByPriceLowToHigh)
            break
            
        case .PriceHigh:
            
            let sortedByPriceLowToHigh = hotelSearchResultArray.sorted { hotel1, hotel2 in
                return (hotel1.price ?? "0.0") > (hotel2.price ?? "0.0")
            }
            setupTVCells(hotelList: sortedByPriceLowToHigh)
            break
            
        case .hotelaz:
            // Sort hotel names alphabetically
            let sortedByNameAZ = hotelSearchResultArray.sorted { $0.name?.localizedCaseInsensitiveCompare($1.name ?? "") == .orderedAscending }
            setupTVCells(hotelList: sortedByNameAZ)
            break
            
        case .hotelza:
            // Sort hotel names alphabetically
            let sortedByNameAZ = hotelSearchResultArray.sorted { $0.name?.localizedCaseInsensitiveCompare($1.name ?? "") == .orderedDescending }
            setupTVCells(hotelList: sortedByNameAZ)
            break
            
            
        case .nothing:
            setupTVCells(hotelList: hotelSearchResultArray)
            break
            
        default:
            break
        }
        
        DispatchQueue.main.async {[self] in
            // commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
        
    }
    
    func filterByApplied(minpricerange: Double, maxpricerange: Double, noofstopsFA: [String], departureTimeFilter: [String], arrivalTimeFilter: [String], airlinesFA: [String], cancellationTypeFA: [String], connectingFlightsFA: [String], connectingAirportsFA: [String]) {
        
    }
    
}




//MARK: - gotoSelectedHotelInfoVC

extension HotelSearchResultVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? HotelSearchResultTVCell {
            hotelid = cell.hotelcode
            grandTotal = cell.kwdlbl.text ?? ""
            hbooking_source = cell.bs
            gotoSelectedHotelInfoVC()
        }
    }
    
    func gotoSelectedHotelInfoVC(){
        guard let vc = SelectedHotelInfoVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        self.present(vc, animated: false)
    }
}



//MARK: - addObserver reload gotoNoInternetScreen
extension HotelSearchResultVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        TimerManager.shared.delegate = self
        
        if callapibool == true {
            holderView.isHidden = true
            callGetActiveSourceBookingSourchAPI()
        }
    }
    
    
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    
    //MARK: - resultnil
    @objc func resultnil(notification: NSNotification){
        gotoNoInternetScreen(keystr: "noresult")
    }
    
    
    func gotoNoInternetScreen(keystr:String) {
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = keystr
        self.present(vc, animated: false)
    }
    
    
    @objc func offline(notificatio:UNNotification) {
        gotoNoInternetScreen(keystr: "offline")
    }
    
    
    func timerDidFinish() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func updateTimer() {
        let totalTime = TimerManager.shared.totalTime
        let minutes =  totalTime / 60
        let seconds = totalTime % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        
        setuplabels(lbl: sessionlbl, text: "Your Session Expires In: \(formattedTime)",
                    textcolor: .AppLabelColor,
                    font: .OpenSansRegular(size: 12),
                    align: .left)
    }
    
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.2
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
}
