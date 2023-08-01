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
    
    
    var payload = [String:Any]()
    var isVcFrom = String()
    var tablerow = [TableRow]()
    var hotelSearchResult = [HotelSearchResult]()
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
        hotelSearchResult = response.data?.hotelSearchResult ?? []
        
        TimerManager.shared.totalTime = response.session_expiry_details?.session_start_time ?? 0
        TimerManager.shared.startTimer()
        
        setupLabels(lbl: sessionlbl, text: "Your Session Expires In: \(response.session_expiry_details?.session_start_time ?? 0)", textcolor: .WhiteColor, font: .OpenSansRegular(size: 12))
        setupLabels(lbl: subtitlelbl, text: "\(hotelSearchResult.count) Hotels Found", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12))
        
        
        
        
        DispatchQueue.main.async {
            self.setupTVCells(hotelList: self.hotelSearchResult)
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
        vc.delegate1 = self
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




extension HotelSearchResultVC:AppliedHotelFilters {
    
    
    func hotelFilterByApplied(minpricerange: Double, maxpricerange: Double, starRating: String, hotelAZAndZAfilter: String) {
        
        
        print("====minpricerange ==== \(minpricerange)")
        print("====maxpricerange ==== \(maxpricerange)")
        print(" ==== starRating === \n\(starRating)")
        
        let filteredArray = hotelSearchResult.filter { i in
            guard let netPrice = Double(i.price ?? "0.0") else { return false }
            let ratingMatches = i.star_rating == Int(starRating) || starRating.isEmpty
            return ratingMatches &&
            netPrice >= minpricerange &&
            netPrice <= maxpricerange
        }
        
        let sortedArray: [HotelSearchResult]
        if hotelAZAndZAfilter == "A-Z" {
            sortedArray = filteredArray.sorted { $0.name ?? "" < $1.name ?? "" }
        } else if hotelAZAndZAfilter == "Z-A" {
            sortedArray = filteredArray.sorted { $0.name ?? "" > $1.name ?? "" }
        } else {
            sortedArray = filteredArray
        }
        
        setupTVCells(hotelList: sortedArray)
        
    }
    
    
    
    
    
    
    
    
    func setupTVCells(hotelList:[HotelSearchResult]) {
        prices.removeAll()
        
        if hotelSearchResult.count == 0 {
            tablerow.removeAll()
            
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }else {
            tablerow.removeAll()
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            
            hotelSearchResult.forEach { i in
                
                prices.append(i.price ?? "")
                tablerow.append(TableRow(title:i.name,
                                         subTitle: i.address,
                                         text: "\(i.currency ?? ""):\(i.price ?? "")",
                                         buttonTitle: String(i.hotel_code ?? 0),
                                         image: i.image,
                                         tempText: "Refundable",
                                         characterLimit: i.star_rating,
                                         cellType:.HotelSearchResultTVCell))
            }
            
            
            prices = Array(Set(prices))
            
            
            
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
        
        
        
    }
    
    
}
