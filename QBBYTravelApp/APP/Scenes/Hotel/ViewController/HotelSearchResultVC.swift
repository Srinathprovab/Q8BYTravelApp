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
    
    var isSearchBool = false
    var payload = [String:Any]()
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
    
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
        
        if callapibool == true {
            holderView.isHidden = true
            callAPI()
        }
        
        
        TimerManager.shared.delegate = self
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
    
    
    
    func callAPI() {
        viewModel?.CALL_GET_HOTEL_LIST_API(dictParam: payload)
    }
    
    func hotelList(response: HotelListModel) {
        
        hsearch_id = String(response.search_id ?? 0)
        hbooking_source = response.booking_source ?? ""
        holderView.isHidden = false
        hotelSearchResultArray = response.data?.hotelSearchResult ?? []
        
        TimerManager.shared.totalTime = response.session_expiry_details?.session_start_time ?? 0
        TimerManager.shared.startTimer(time: 900)
        
        setupLabels(lbl: sessionlbl, text: "Your Session Expires In: \(response.session_expiry_details?.session_start_time ?? 0)", textcolor: .WhiteColor, font: .OpenSansRegular(size: 12))
        setupLabels(lbl: subtitlelbl, text: "\(hotelSearchResultArray.count) Hotels Found", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12))
        
        
        
        
        DispatchQueue.main.async {
            self.setupTVCells(hotelList: self.hotelSearchResultArray)
        }
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
        
        
        nav.titlelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "")"
        nav.citylbl.text = "CheckIn -\(defaults.string(forKey: UserDefaultsKeys.checkin) ?? "" ) CheckOut -\(defaults.string(forKey: UserDefaultsKeys.checkout) ?? "")"
        
        nav.datelbl.text = "Guests-1 \(defaults.string(forKey: UserDefaultsKeys.guestcount) ?? "")/ Room - \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "")"
        
        
        nav.backBtn.addTarget(self, action: #selector(backbtnAction(_:)), for: .touchUpInside)
        nav.editBtn.addTarget(self, action: #selector(modifySearchHotel(_:)), for: .touchUpInside)
        
        
        
        let screenHeight = UIScreen.main.bounds.size.height
        if screenHeight > 835 {
            navHeight.constant = 180
        }else {
            navHeight.constant = 180
        }
        
        
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "HotelSearchResultTVCell"])
        
    }
    
    
    
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
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
    
    @objc func modifySearchHotel(_ sender:UIButton) {
        guard let vc = BookHotelVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.isVcFrom = "modify"
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
        self.present(vc, animated: false)
    }
    
    
}


extension HotelSearchResultVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? HotelSearchResultTVCell {
            hotelid = cell.hotelcode
            grandTotal = cell.kwdlbl.text ?? ""
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







extension HotelSearchResultVC:AppliedFilters {
    
    
    func hotelFilterByApplied(minpricerange: Double, maxpricerange: Double, starRating: String, refundableTypeArray: [String], nearByLocA: [String], niberhoodA: [String], aminitiesA: [String]) {
        
        
        isSearchBool = true
        
        print("====minpricerange ==== \(minpricerange)")
        print("====maxpricerange ==== \(maxpricerange)")
        print(" ==== starRating === \(starRating)")
        print(" ==== refundableTypeArray === \n\(refundableTypeArray)")
        print(" ==== nearByLocA === \n\(nearByLocA)")
        print(" ==== niberhoodA === \n\(niberhoodA)")
        print(" ==== aminitiesA === \n\(aminitiesA)")
        
        
        
        let filteredArray = hotelSearchResultArray.filter { hotel in
            guard let netPrice = Double(hotel.price ?? "0.0") else { return false }
            
            let ratingMatches = hotel.star_rating == Int(starRating) || starRating.isEmpty
       //     let refundableMatch = refundableTypeArray.isEmpty || refundableTypeArray.contains(hotel.refund ?? "")
            let nearByLocMatch = nearByLocA.isEmpty || nearByLocA.contains(hotel.location ?? "")

            
            let facilityMatch = aminitiesA.isEmpty || aminitiesA.allSatisfy { desiredAmenity in
                hotel.facility?.contains { facility in
                    let facilityName = facility.name?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
                    return facilityName == desiredAmenity.lowercased()
                } ?? false
            }


            return ratingMatches && netPrice >= minpricerange && netPrice <= maxpricerange && facilityMatch && nearByLocMatch
            
            
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
                return (Double(hotel1.price ?? "") ?? 0.0) < (Double(hotel2.price ?? "") ?? 0.0)
            }
          
            setupTVCells(hotelList: sortedByPriceLowToHigh)
            break
            
        case .PriceHigh:
            
            let sortedByPriceLowToHigh = hotelSearchResultArray.sorted { hotel1, hotel2 in
                return (Double(hotel1.price ?? "") ?? 0.0) > (Double(hotel2.price ?? "") ?? 0.0)
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
    
    
    
    
    
    
    func setupTVCells(hotelList:[HotelSearchResult]) {
        
        
        if hotelList.count == 0 {
            tablerow.removeAll()
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            commonTVData = tablerow
            commonTableView.reloadData()
        }else {
            tablerow.removeAll()
            setupLabels(lbl: subtitlelbl, text: "\(hotelList.count) Hotels Found", textcolor: .WhiteColor, font: .OpenSansRegular(size: 12))
            hotelList.forEach { i in
                tablerow.append(TableRow(title:i.name,
                                         subTitle: "\(i.address ?? "")",
                                         kwdprice: "\(i.currency ?? "") \(i.price ?? "")",
                                         text: "\(i.hotel_code ?? 0)",
                                         image: i.image,
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
