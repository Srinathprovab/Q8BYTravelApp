//
//  HolidaysSearchResultVC.swift
//  QBBYTravelApp
//
//  Created by FCI on 24/05/23.
//

import UIKit

class HolidaysSearchResultVC: BaseTableVC, HolidaySearchResultViewModelDelegate {
    
    @IBOutlet weak var sessionlbl: UILabel!
    @IBOutlet weak var hotelsFoundlbl: UILabel!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var mapsearchBtn: UIButton!
    
    
    static var newInstance: HolidaysSearchResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Holiday.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HolidaysSearchResultVC
        return vc
    }
    
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var vm:HolidaySearchResultViewModel?
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        if callapibool == true {
            self.holderView.isHidden = true
            callAPI()
        }
    }
    
    func callAPI() {
        payload["term"] = defaults.string(forKey: UserDefaultsKeys.holidaylocationcity) ?? ""
        vm?.CALL_HOLIDAY_SEARCH_LIST_API(dictParam: payload)
    }
    
    var hsearchResult = [SearchResult]()
    func holidaySearchList(response: HolidaySearchResultModel) {
        
        hsearchResult = response.searchResult ?? []
        setuplabels(lbl: nav.citylbl, text: defaults.string(forKey: UserDefaultsKeys.holidaylocationcity) ?? "", textcolor: .WhiteColor, font: .OpenSansMedium(size: 15), align: .center)
        hotelsFoundlbl.text = "\(hsearchResult.count ) Hotels Found"
        
        DispatchQueue.main.async {
            self.holderView.isHidden = false
            self.setupTVCells()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = HolidaySearchResultViewModel(self)
    }
    
    
    func setupUI() {
        
        nav.citylbl.isHidden = false
        nav.editView.isHidden = false
        nav.editView.backgroundColor = .AppBtnColor
        setuplabels(lbl: nav.titlelbl, text: "Search Result", textcolor: .WhiteColor, font: .OpenSansMedium(size: 20), align: .center)
        nav.backBtn.addTarget(self, action: #selector(backbtnAction), for: .touchUpInside)
        mapView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 4)
        mapsearchBtn.setTitle("", for: .normal)
        mapsearchBtn.addTarget(self, action: #selector(didTapOnMapBtnAction(_:)), for: .touchUpInside)
        nav.editBtn.addTarget(self, action: #selector(didTapOnEditSearchHolidayBtnAction(_:)), for: .touchUpInside)
        filterView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 4)
        filterBtn.setTitle("", for: .normal)
        filterBtn.addTarget(self, action: #selector(didTapOnEditSearchHolidayBtnAction(_:)), for: .touchUpInside)
        
        
        commonTableView.registerTVCells(["HolidaySearchResultTVCell",
                                         "EmptyTVCell"])
        
    }
    
    
    func setupTVCells() {
        tablerow.removeAll()
        
        
        hsearchResult.forEach { i in
            tablerow.append(TableRow(title:i.name,
                                     subTitle: "3== days/ \(i.no_of_nights ?? "") nights",
                                     text: "\(i.currency ?? ""):\(i.adult_price ?? "")==",
                                     buttonTitle: i.id,
                                     image: "\(i.url ?? "")\(i.banner_image ?? "")",
                                     characterLimit: 3,
                                     cellType:.HolidaySearchResultTVCell))
        }
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    @objc func didTapOnHolidayFilterBtnAction(_ sender:UIButton){
        print("didTapOnHolidayFilterBtnAction")
    }
    
    @objc func didTapOnMapBtnAction(_ sender:UIButton){
        print("didTapOnMapBtnAction")
    }
    
    
    @objc func didTapOnEditSearchHolidayBtnAction(_ sender:UIButton){
        guard let vc = BookHolidayVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        vc.isfromvc = "HolidaysSearchResultVC"
        present(vc, animated: true)
    }
    
    @objc func backbtnAction() {
        dismiss(animated: true)
    }
    
    
    override func didTapOnHolidayDetailsBtnAction(cell:HolidaySearchResultTVCell){
        guard let vc = HolidayDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        vc.packegId = cell.packageid
        present(vc, animated: true)
    }
}
