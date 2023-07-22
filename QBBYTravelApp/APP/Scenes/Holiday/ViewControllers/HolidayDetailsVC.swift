//
//  HolidayDetailsVC.swift
//  QBBYTravelApp
//
//  Created by FCI on 24/05/23.
//

import UIKit

class HolidayDetailsVC: BaseTableVC, HolidayDetailsViewModelDelegate {
   
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    
    
    static var newInstance: HolidayDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Holiday.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HolidayDetailsVC
        return vc
    }
    
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var packegId = String()
    var vm:HolidayDetailsViewModel?
    
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
    }
    
    
    func callAPI() {
        payload["tour_id"] = packegId
        payload["term"] = defaults.string(forKey: UserDefaultsKeys.holidaylocationcity)
        vm?.CALL_HOLIDAY_DETAILS_API(dictParam: payload)
    }
    
    
    func holidayDetails(response: HolidayDetailsModel) {
        print("holidayDetails holidayDetails holidayDetails")
        holderView.isHidden = false
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = HolidayDetailsViewModel(self)
    }
    
    
    func setupUI() {
        setuplabels(lbl: nav.titlelbl, text: "Holiday Details", textcolor: .WhiteColor, font: .OpenSansMedium(size: 20), align: .center)
        nav.backBtn.addTarget(self, action: #selector(backbtnAction), for: .touchUpInside)
        commonTableView.isScrollEnabled = false
        commonTableView.backgroundColor = .AppHolderViewColor
       // commonTableView.registerTVCells([""])
        setupTVCells()
    }
    
    
    func setupTVCells() {
        tablerow.removeAll()
        
       
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    @objc func backbtnAction() {
        callapibool = false
        dismiss(animated: true)
    }
    
    
}
