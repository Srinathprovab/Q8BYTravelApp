//
//  BookHolidayVC.swift
//  QBBYTravelApp
//
//  Created by FCI on 24/05/23.
//

import UIKit

class BookHolidayVC: BaseTableVC {
    
    @IBOutlet weak var nav: NavBar!
    
    
    static var newInstance: BookHolidayVC? {
        let storyboard = UIStoryboard(name: Storyboard.Holiday.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookHolidayVC
        return vc
    }
    
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var isfromvc = String()
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
    }
    
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        nav.backBtn.tintColor = .AppLabelColor
        nav.holderview.backgroundColor = .WhiteColor
        setuplabels(lbl: nav.titlelbl, text: "Book Your Holiday Deals", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 20), align: .center)
        nav.backBtn.addTarget(self, action: #selector(backbtnAction), for: .touchUpInside)
        commonTableView.isScrollEnabled = false
        commonTableView.backgroundColor = .AppHolderViewColor
        commonTableView.registerTVCells(["SearchHolidaysTVcell",
                                         "DashboardDealsTitleTVCell",
                                         "EmptyTVCell",
                                         "HotelDealsTVCell"])
        
        
        if isfromvc == "bookholiday" {
            setupTVCells()
        }else {
            setupModifySearchTVCells()
        }
    }
    
    
    func setupTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.SearchHolidaysTVcell))
        tablerow.append(TableRow(title:"BEST HOLIDAY DESTINATIONS",
                                 key: "deals",
                                 text:imgPath,
                                 height:50,
                                 cellType:.DashboardDealsTitleTVCell))
        tablerow.append(TableRow(height:20,
                                 bgColor: .AppHolderViewColor,
                                 cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:imgPath,
                                 key:"holiday",
                                 cellType:.HotelDealsTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func setupModifySearchTVCells() {
        
        nav.backBtn.tintColor = .WhiteColor
        nav.holderview.backgroundColor = .AppBackgroundColor
        setuplabels(lbl: nav.titlelbl, text: "Modify Search", textcolor: .WhiteColor, font: .OpenSansMedium(size: 20), align: .center)
        commonTableView.backgroundColor = .WhiteColor
        
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.SearchHolidaysTVcell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
    }
    
    
    @objc func backbtnAction() {
        dismiss(animated: true)
    }
    
    override func didTapOnWhereToTravelSearchBtnAction(cell: SearchHolidaysTVcell) {
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = "Location/ City"
        vc.keyStr = "holiday"
        self.present(vc, animated: false)
    }
    
    override func didTapOnSearchHolidayBtnAction(cell: SearchHolidaysTVcell) {
        guard let vc = HolidaysSearchResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    
}
