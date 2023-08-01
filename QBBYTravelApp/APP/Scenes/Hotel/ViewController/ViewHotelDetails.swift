//
//  ViewHotelDetails.swift
//  QBBYTravelApp
//
//  Created by FCI on 22/05/23.
//

import UIKit

class ViewHotelDetails: BaseTableVC, TimerManagerDelegate {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
   
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var isVcFrom = String()
   
    
    static var newInstance: ViewHotelDetails? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ViewHotelDetails
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
        
        DispatchQueue.main.async {
            self.appendHotelSearctTvcells()
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        
        self.holderView.backgroundColor = .AppHolderViewColor
        nav.titlelbl.text = "Hotel Details"
        nav.backBtn.addTarget(self, action: #selector(backbtnAction(_:)), for: .touchUpInside)
        navHeight.constant = 130
        
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
        tablerow.append(TableRow(height:20,bgColor: .AppHolderViewColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(image:hotelimg,moreData:hotelImages,cellType:.HotelImagesTVCell))
        tablerow.append(TableRow(title:"Description",
                                 subTitle: hotelDetalsinfo?.hotel_desc,
                                 cellType:.RatingWithLabelsTVCell))
        
        tablerow.append(TableRow(height:50,bgColor: .AppHolderViewColor,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
}
