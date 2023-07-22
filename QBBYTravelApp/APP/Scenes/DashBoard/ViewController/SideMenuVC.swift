//
//  SideMenuVC.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit

class SideMenuVC: BaseTableVC, ProfileUpdateViewModelDelegate {
    
    @IBOutlet weak var holderView: UIView!
    
    static var newInstance: SideMenuVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SideMenuVC
        return vc
    }
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var vm:LogoutViewmodel?
    var vm1:ProfileUpdateViewModel?
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loginDone), name: NSNotification.Name("logindon"), object: nil)
       
        
        let logstatus = defaults.bool(forKey: UserDefaultsKeys.userLoggedIn)
        if logstatus == true {
            callProfileDetailsAPI()
        }
    }
    
    //MARK: - callProfileDetailsAPI
    func callProfileDetailsAPI() {
        
        payload.removeAll()
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
        vm1?.CALL_SHOW_PROFILE_API(dictParam: payload)
    }
    
    func profileDetails(response: ProfileUpdateModel) {
        profildata = response.data
        DispatchQueue.main.async {
            self.setupMenuTVCells()
        }
    }
    
    
    @objc func loginDone() {
        callProfileDetailsAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = LogoutViewmodel(self)
        vm1 = ProfileUpdateViewModel(self)
        
    }
    
    
    func setupUI(){
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        holderView.backgroundColor = .clear
        
        if screenHeight > 835 {
            commonTableView.isScrollEnabled = false
        }
        
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["MenuBGTVCell",
                                         "checkOptionsTVCell",
                                         "EmptyTVCell",
                                         "MenuTitleTVCell",
                                         "AboutusTVCell"])
        
        setupMenuTVCells()
    
    }
    
    
   
    
    //MARK: - setupMenuTVCells
    func setupMenuTVCells() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.MenuBGTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Bookings",key: "ourproducts", image: "",cellType:.MenuTitleTVCell))
        tablerow.append(TableRow(title:"Flights",key: "menu", image: "menu5",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(title:"Hotels",key: "menu", image: "menu6",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(title:"Holiday",key: "menu", image: "menu6",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Traveler Tools",key: "ourproducts", image: "",cellType:.MenuTitleTVCell))
        tablerow.append(TableRow(title:"Check My Bookings",key: "menu", image: "menu1",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(title:"FAQ's",key: "menu", image: "menu2",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Legal",key: "ourproducts", image: "",cellType:.MenuTitleTVCell))
        tablerow.append(TableRow(cellType:.AboutusTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))

 
        if defaults.bool(forKey: UserDefaultsKeys.userLoggedIn) == true {
            tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
            tablerow.append(TableRow(title:"Logout",key: "menu", image: "logout",cellType:.checkOptionsTVCell))
            tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        }
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - didTapOnLoginBtn
    override func didTapOnLoginBtn(cell: MenuBGTVCell) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
        
    }
    
    
    
    //MARK: - didTapOnEditProfileBtn
    override func didTapOnEditProfileBtn(cell: MenuBGTVCell) {
        guard let vc = EditProfileVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    
    
    //MARK: - didTapOnMenuOptionBtn
    override func didTapOnMenuOptionBtn(cell:checkOptionsTVCell){
        switch cell.titlelbl.text {
        case "My Bookings":
            gotoMyBookingVC()
            break
            
        case "Flights":
            gotoBookFlightsVC()
            break
            
        case "Hotels":
            gotoBookHotelsVC()
            break
            
        case "Logout":
            payload.removeAll()
            vm?.CALL_LOgout_API(dictParam: [:])
            break
            
        default:
            break
        }
    }
    
    
    
    //MARK: - didTapOnAboutUsLink
    func gotoBookFlightsVC() {
        guard let vc = BookFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    
    
    //MARK: - gotoBookHotelsVC
    func gotoBookHotelsVC() {
        guard let vc = BookHotelVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    
    
    //MARK: - gotoMyBookingVC
    func gotoMyBookingVC() {
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.selectedIndex = 1
        present(vc, animated: true)
    }
    
    
    
    //MARK: - didTapOnAboutUsLink
    override func didTapOnAboutUsLink(cell: AboutusTVCell) {
        gotoAboutUsVC(keystr: "aboutus")
    }
    
    //MARK: - didTapOnTermsLink
    override func didTapOnTermsLink(cell: AboutusTVCell) {
        gotoAboutUsVC(keystr: "terms")
    }
    
    //MARK: - didTapOnCoockiesLink
    override func didTapOnContactUsBtnAction(cell: AboutusTVCell) {
        gotoAboutUsVC(keystr: "contactus")
    }
    
    
    func gotoAboutUsVC(keystr:String) {
        guard let vc = AboutUsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.keystr = keystr
        present(vc, animated: true)
    }
    
}


extension SideMenuVC:LogoutViewmodelDelegate {
    func logoutSucess(response: LoginModel) {
        showToast(message: response.data ?? "")
        defaults.set(false, forKey: UserDefaultsKeys.userLoggedIn)
        DispatchQueue.main.async {[self] in
            setupMenuTVCells()
        }
    }
    
}
