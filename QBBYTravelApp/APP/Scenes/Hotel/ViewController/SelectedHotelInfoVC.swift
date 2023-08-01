//
//  SelectedHotelInfoVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//

import UIKit

class SelectedHotelInfoVC: BaseTableVC, HotelDetailsViewModelDelegate, TimerManagerDelegate {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var bookNowHolderView: UIView!
    @IBOutlet weak var kwdpricelbl: UILabel!
    @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    
    var vm:HotelDetailsViewModel?
    var payload = [String:Any]()
    var isVcFrom = String()
    var tablerow = [TableRow]()
    var roomsInfo = [[Rooms]]()
    var facilityesInfo = [Facility]()
    
    
    static var newInstance: SelectedHotelInfoVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectedHotelInfoVC
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
        
    }
    
    
    func callAPI() {
        payload.removeAll()
        payload["booking_source"] = hbooking_source
        payload["hotel_id"] = hotelid
        payload["search_id"] = hsearch_id
        vm?.CALL_GET_HOTEL_DETAILS_API(dictParam: payload)
    }
    
    
    func hotelDetails(response: HotelDetailsModel) {
        
        holderView.isHidden = false
        hotelDetalsinfo = response.hotel_details
        roomsInfo = response.hotel_details?.rooms ?? [[]]
        facilityesInfo = response.hotel_details?.facility ?? []
        hotelImages = response.hotel_details?.images ?? []
        hotelimg = response.hotel_details?.image ?? ""
        htoken = response.hotel_details?.token ?? ""
        htokenkey = response.hotel_details?.tokenKey ?? ""
        
        DispatchQueue.main.async {
            self.appendHotelSearctTvcells()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        vm = HotelDetailsViewModel(self)
    }
    
    func setupUI() {
        
        self.view.backgroundColor = .WhiteColor
        self.holderView.backgroundColor = .WhiteColor
        
        nav.backBtn.addTarget(self, action: #selector(backbtnAction(_:)), for: .touchUpInside)
        nav.citylbl.isHidden = false
        nav.datelbl.isHidden = false
        
        
        nav.titlelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "")"
        nav.citylbl.text = "CheckIn -\(defaults.string(forKey: UserDefaultsKeys.checkin) ?? "" ) CheckOut -\(defaults.string(forKey: UserDefaultsKeys.checkout) ?? "")"
        
        nav.datelbl.text = "Guests-1 \(defaults.string(forKey: UserDefaultsKeys.guestcount) ?? "")/ Room - \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "")"
        
        
        if screenHeight > 835 {
            navHeight.constant = 200
        }else {
            navHeight.constant = 180
        }
        
        setupViews(v: bookNowHolderView, radius: 0, color: .AppBackgroundColor)
        setupViews(v: bookNowView, radius: 20, color: .layoverColor)
        setupLabels(lbl: kwdpricelbl, text: grandTotal, textcolor: .WhiteColor, font: .oswaldRegular(size: 20))
        setupLabels(lbl: bookNowlbl, text: "CONTINUE", textcolor: .AppLabelColor, font: .oswaldRegular(size: 16))
        bookNowBtn.setTitle("", for: .normal)
        bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowBtn(_:)), for: .touchUpInside)
        
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "RatingWithLabelsTVCell",
                                         "FacilitiesTVCell",
                                         "HotelImagesTVCell",
                                         "RoomsTVCell"])
        
    }
    
    
    @objc func backbtnAction(_ sender:UIButton) {
        callapibool = false
        dismiss(animated: true)
    }
    
    func appendHotelSearctTvcells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:hotelDetalsinfo?.name,
                                 subTitle: hotelDetalsinfo?.address,
                                 key:"rating",
                                 characterLimit: hotelDetalsinfo?.star_rating,
                                 cellType:.RatingWithLabelsTVCell))
        tablerow.append(TableRow(height:20,bgColor: .WhiteColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(image:hotelimg,moreData:hotelImages,cellType:.HotelImagesTVCell))
        tablerow.append(TableRow(title:"Description",
                                 subTitle: hotelDetalsinfo?.hotel_desc,
                                 cellType:.RatingWithLabelsTVCell))
        tablerow.append(TableRow(title:"Rooms", moreData:roomsInfo,cellType:.RoomsTVCell))
        tablerow.append(TableRow(title:"Facilities",moreData: facilityesInfo,cellType:.FacilitiesTVCell))
        tablerow.append(TableRow(height:50,bgColor: .WhiteColor,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
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
    
    
    override func didTapOnCancellationPolicyBtn(cell: TwinSuperiorRoomTVCell) {
        guard let vc = CancellationPolicyPopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.amount = cell.CancellationPolicyAmount
        vc.datetime = cell.CancellationPolicyFromDate
        self.present(vc, animated: false)
    }
    
    @objc func didTapOnBookNowBtn(_ sender:UIButton) {
        if ratekeyArray.isEmpty == true {
            showToast(message: "Please Select Room To Book")
        }else {
            guard let vc = PayNowVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            vc.keystr = "hotel"
            self.present(vc, animated: false)
        }
        
    }
    
    
}

