//
//  AboutUsVC.swift
//  QBBYTravelApp
//
//  Created by FCI on 05/04/23.
//

import UIKit

class AboutUsVC: BaseTableVC,AboutusViewModelDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var pageTitlelbl: UILabel!
    @IBOutlet weak var appLogo: UIImageView!
    
    
    static var newInstance: AboutUsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AboutUsVC
        return vc
    }
    var tablerow = [TableRow]()
    var page_title = String()
    var page_description = String()
    var keystr = String()
    var vm:AboutusViewModel?
    
    
    override func viewWillDisappear(_ animated: Bool) {
        BASE_URL = BASE_URL1
    }
   
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        holderView.isHidden = true
        callAPI()
    }
    
    func callAPI() {
        BASE_URL = ""
        switch keystr {
        case "aboutus":
            vm?.CALL_ABOUTUS_API(dictParam: [:], url: "https://q8by.com/mobile_webservices/index.php/general/cms?id=1")
            break
        case "contactus":
            vm?.CALL_ABOUTUS_API(dictParam: [:], url: "https://q8by.com/mobile_webservices/index.php/general/cms?id=6")
            break
            
        default:
            break
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = AboutusViewModel(self)
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["AboutustitleTVCell",
                                         "EmptyTVCell"])
        commonTableView.isScrollEnabled = false
    }
    
    
    @IBAction func gotoBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    func aboutusDetails(response: AboutusModel) {
        holderView.isHidden = false
        self.page_description = response.data?.first?.page_description ?? ""
        setuplabels(lbl: pageTitlelbl, text: response.data?.first?.page_title ?? "", textcolor: .WhiteColor, font: .LatoSemibold(size: 18), align: .center)
        
        DispatchQueue.main.async {[self] in
            setupTVCells()
        }
    }
    
    
    func setupTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:self.page_description,cellType:.AboutustitleTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
}

