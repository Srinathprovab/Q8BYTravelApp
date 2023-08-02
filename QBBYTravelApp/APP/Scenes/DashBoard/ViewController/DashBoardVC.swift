//
//  DashBoardVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit

class DashBoardVC: BaseTableVC, HomePageViewModelDelegate, GetCountryListViewModelDelegate {
    
    var tablerow = [TableRow]()
    static var newInstance: DashBoardVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? DashBoardVC
        return vc
    }
    
    var vm1:GetCountryListViewModel?
    var vm:HomePageViewModel?
    var payload = [String:Any]()
    
    //MARK: - side menu initial setup
    private var sideMenuViewController: SideMenuVC!
    private var sideMenuShadowView: UIView!
    private var sideMenuRevealWidth: CGFloat = 260
    private let paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    private var draggingIsEnabled: Bool = false
    private var panBaseLocation: CGFloat = 0.0
    
    
    
    //MARK: - Expand/Collapse the side menu by changing trailing's constant
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    var gestureEnabled: Bool = true
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            
            if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
                
                defaults.set("Airline", forKey: UserDefaultsKeys.tabselect)
                defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
                defaults.set("KWD", forKey: UserDefaultsKeys.selectedCurrency)
                defaults.set("Economy", forKey: UserDefaultsKeys.selectClass)
                defaults.set("1", forKey: UserDefaultsKeys.adultCount)
                defaults.set("0", forKey: UserDefaultsKeys.childCount)
                defaults.set("0", forKey: UserDefaultsKeys.infantsCount)
                defaults.set("1", forKey: UserDefaultsKeys.totalTravellerCount)
                
                
                let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller - \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy")"
                
                
                defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
                defaults.set("1", forKey: UserDefaultsKeys.totalTravellerCount)
                
                defaults.set("Economy", forKey: UserDefaultsKeys.rselectClass)
                defaults.set("1", forKey: UserDefaultsKeys.radultCount)
                defaults.set("0", forKey: UserDefaultsKeys.rchildCount)
                defaults.set("0", forKey: UserDefaultsKeys.rinfantsCount)
                
                let totaltraverlers1 = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller - \(defaults.string(forKey: UserDefaultsKeys.rselectClass) ?? "Economy")"
                defaults.set(totaltraverlers1, forKey: UserDefaultsKeys.rtravellerDetails)
                
                
                defaults.set("Economy", forKey: UserDefaultsKeys.mselectClass)
                defaults.set("1", forKey: UserDefaultsKeys.madultCount)
                defaults.set("0", forKey: UserDefaultsKeys.mchildCount)
                defaults.set("0", forKey: UserDefaultsKeys.minfantsCount)
                
                let totaltraverlers3 = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller - \(defaults.string(forKey: UserDefaultsKeys.mselectClass) ?? "Economy")"
                defaults.set(totaltraverlers3, forKey: UserDefaultsKeys.mtravellerDetails)
                
                
                UserDefaults.standard.set(true, forKey: "ExecuteOnce")
            }
        }
        
        //Hotel default Values
        defaults.set("1", forKey: UserDefaultsKeys.roomcount)
        defaults.set("1", forKey: UserDefaultsKeys.hoteladultscount)
        defaults.set("0", forKey: UserDefaultsKeys.hotelchildcount)
        adtArray.removeAll()
        chArray.removeAll()
        adtArray.append("1")
        chArray.append("0")
        defaults.set("\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "") Rooms,\(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "") Adults,\(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "") Childreen", forKey: UserDefaultsKeys.selectPersons)
        defaults.set(1, forKey: UserDefaultsKeys.guestcount)
        
        if callapibool == true {
            callApi()
        }
    }
    
    
    
    func callApi(){
        vm?.CALL_HOME_PAGE_DETAILS_API(dictParam: [:])
    }
    
    
    
    func homepageDetails(response: HomePageModel) {
        imgPath = response.img_url ?? ""
        besttopflightArray = response.flight_top_destinations1 ?? []
        besttopHotelArray = response.flight_top_destinations1 ?? []
        perfectholidaysArray = response.perfect_holidays ?? []
        
        DispatchQueue.main.async {[self] in
            appendLoginTvcells()
        }
        
        DispatchQueue.main.async {[self] in
            callcountryLiatAPI()
        }
    }
    
    func callcountryLiatAPI() {
        vm1?.CALL_GET_COUNTRY_LIST_API(dictParam: [:])
    }
    
    
    func countryList(response: GetCountryListModel) {
        countrylist = response.data?.country_list ?? []
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupTV()
        setupMenu()
        
        vm = HomePageViewModel(self)
        vm1 = GetCountryListViewModel(self)
    }
    
    
    func setupTV() {
        self.view.backgroundColor = .AppHolderViewColor
        
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "LogowithMenuTVCell",
                                         "HotelDealsTVCell",
                                         "SelectTabTVCell",
                                         "DashboardDealsTitleTVCell"])
        
    }
    
    
    //MARK: - appendLoginTvcells
    func appendLoginTvcells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.LogowithMenuTVCell))
        
        //  tablerow.append(TableRow(title:"BEST HOLIDAY DESTINATIONS",key: "deals", text:imgPath, height:50,cellType:.DashboardDealsTitleTVCell))
        tablerow.append(TableRow(title:imgPath,key:"holiday",cellType:.HotelDealsTVCell))
        //
        //        tablerow.append(TableRow(title:"BEST DEALS FLIGHTS",key: "deals", text:imgPath, height:50,cellType:.DashboardDealsTitleTVCell))
        //        tablerow.append(TableRow(title:imgPath,key:"flight",cellType:.HotelDealsTVCell))
        //
        //        tablerow.append(TableRow(title:"BEST HOTELS",key: "deals", text:imgPath, height:50,cellType:.DashboardDealsTitleTVCell))
        //        tablerow.append(TableRow(title:imgPath,key:"hotel",cellType:.HotelDealsTVCell))
        
        tablerow.append(TableRow(key:"home",cellType:.SelectTabTVCell))
        tablerow.append(TableRow(height:30,bgColor: .WhiteColor,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    //MARK: - didTapOnDashboardTab
    override func didTapOnDashboardTab(cell: SelectTabTVCell) {
        
        let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
        switch tabselect {
        case "Airline":
            gotoBookingFlightVC()
            break
            
        case "Hotel":
           // gotoBookHotelVC()
            break
            
            
        case "Holiday":
            // gotoBookHolidayVC()
            break
            
        default:
            break
        }
    }
    
    
    //MARK: - gotoBookingFlightVC
    func gotoBookingFlightVC() {
        guard let vc = BookFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    //MARK: - gotoBookHotelVC
    func gotoBookHotelVC() {
        guard let vc = BookHotelVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.isVcFrom = "dashboard"
        self.present(vc, animated: true)
    }
    
    
    
    //MARK: - gotoBookHotelVC
    func gotoBookHolidayVC() {
        guard let vc = BookHolidayVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.isfromvc = "bookholiday"
        self.present(vc, animated: true)
    }
    
    //MARK: - didTapOnLaungageBtn
    override func didTapOnLaungageBtn(cell:LogowithMenuTVCell){
        guard let vc = SelectLanguageVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    //MARK: - didTapOnViewDetailsBtn
    override func didTapOnViewDetailsBtn(cell: HotelDealsTVCell) {
        print(" didTapOnViewDetailsBtn =====  \(cell.indexPath?.row ?? 0)")
    }
    
    
    //MARK:  Call this Button Action from the View Controller you want to Expand/Collapse when you tap a button
    override func didTapOnMenuBtn(cell:LogowithMenuTVCell){
        callapibool = true
        NotificationCenter.default.post(name: NSNotification.Name("callprofileapi"), object: nil)
        self.tabBarController?.tabBar.isHidden = true
        self.sideMenuState(expanded: self.isExpanded ? false : true)
    }
    
    
    //MARK: SETUP SIDE MENU
    func setupMenu(){
        
        //MARK: Shadow Background View
        self.sideMenuShadowView = UIView(frame: self.view.bounds)
        self.sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.sideMenuShadowView.backgroundColor = .black
        self.sideMenuShadowView.alpha = 0.0
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        self.sideMenuShadowView.addGestureRecognizer(tapGestureRecognizer)
        if self.revealSideMenuOnTop {
            view.insertSubview(self.sideMenuShadowView, at: 1)
        }
        
        //MARK: Side Menu
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.sideMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuVC
        view.insertSubview(self.sideMenuViewController!.view, at: self.revealSideMenuOnTop ? 2 : 0)
        addChild(self.sideMenuViewController!)
        self.sideMenuViewController!.didMove(toParent: self)
        
        //MARK: Side Menu AutoLayout
        self.sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        if self.revealSideMenuOnTop {
            self.sideMenuTrailingConstraint = self.sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
            self.sideMenuTrailingConstraint.isActive = true
        }
        NSLayoutConstraint.activate([
            self.sideMenuViewController.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth + 50),
            self.sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        //MARK: Side Menu Gestures
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    //MARK: Keep the state of the side menu (expanded or collapse) in rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = self.isExpanded ? 0 : (-self.sideMenuRevealWidth - self.paddingForRotation)
            }
        }
    }
    
    func animateShadow(targetPosition: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            //MARK: When targetPosition is 0, which means side menu is expanded, the shadow opacity is 0.6
            self.sideMenuShadowView.alpha = (targetPosition == 0) ? 0.6 : 0.0
        }
    }
    
    
    
    func sideMenuState(expanded: Bool) {
        if expanded {
            NotificationCenter.default.post(name: NSNotification.Name("callprofileapi"), object: nil)
            self.tabBarController?.tabBar.isHidden = true
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
                self.isExpanded = true
            }
            // Animate Shadow (Fade In)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.6 }
            callapibool = true
        }
        else {
            self.tabBarController?.tabBar.isHidden = false
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
            }
            // Animate Shadow (Fade Out)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0 }
            
        }
    }
    
    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = targetPosition
                self.view.layoutIfNeeded()
            }
            else {
                self.view.subviews[1].frame.origin.x = targetPosition
            }
        }, completion: completion)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}


extension DashBoardVC: UIGestureRecognizerDelegate {
    @objc func TapGestureRecognizer(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if self.isExpanded {
                self.sideMenuState(expanded: false)
            }
        }
    }
    
    // Close side menu when you tap on the shadow background view
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.sideMenuViewController.view))! {
            return false
        }
        return true
    }
    
    // Dragging Side Menu
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        guard gestureEnabled == true else { return }
        
        let position: CGFloat = sender.translation(in: self.view).x
        let velocity: CGFloat = sender.velocity(in: self.view).x
        
        switch sender.state {
        case .began:
            
            // If the user tries to expand the menu more than the reveal width, then cancel the pan gesture
            if velocity > 0, self.isExpanded {
                sender.state = .cancelled
            }
            
            // If the user swipes right but the side menu hasn't expanded yet, enable dragging
            if velocity > 0, !self.isExpanded {
                self.draggingIsEnabled = true
            }
            // If user swipes left and the side menu is already expanded, enable dragging
            else if velocity < 0, self.isExpanded {
                self.draggingIsEnabled = true
            }
            
            if self.draggingIsEnabled {
                // If swipe is fast, Expand/Collapse the side menu with animation instead of dragging
                let velocityThreshold: CGFloat = 550
                if abs(velocity) > velocityThreshold {
                    self.sideMenuState(expanded: self.isExpanded ? false : true)
                    self.draggingIsEnabled = false
                    return
                }
                
                if self.revealSideMenuOnTop {
                    self.panBaseLocation = 0.0
                    if self.isExpanded {
                        self.panBaseLocation = self.sideMenuRevealWidth
                    }
                }
            }
            
        case .changed:
            
            // Expand/Collapse side menu while dragging
            if self.draggingIsEnabled {
                if self.revealSideMenuOnTop {
                    // Show/Hide shadow background view while dragging
                    let xLocation: CGFloat = self.panBaseLocation + position
                    let percentage = (xLocation * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                    
                    let alpha = percentage >= 0.6 ? 0.6 : percentage
                    self.sideMenuShadowView.alpha = alpha
                    
                    // Move side menu while dragging
                    if xLocation <= self.sideMenuRevealWidth {
                        self.sideMenuTrailingConstraint.constant = xLocation - self.sideMenuRevealWidth
                    }
                }
                else {
                    if let recogView = sender.view?.subviews[1] {
                        // Show/Hide shadow background view while dragging
                        let percentage = (recogView.frame.origin.x * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                        
                        let alpha = percentage >= 0.6 ? 0.6 : percentage
                        self.sideMenuShadowView.alpha = alpha
                        
                        // Move side menu while dragging
                        if recogView.frame.origin.x <= self.sideMenuRevealWidth, recogView.frame.origin.x >= 0 {
                            recogView.frame.origin.x = recogView.frame.origin.x + position
                            sender.setTranslation(CGPoint.zero, in: view)
                        }
                    }
                }
            }
        case .ended:
            self.draggingIsEnabled = false
            // If the side menu is half Open/Close, then Expand/Collapse with animation
            if self.revealSideMenuOnTop {
                let movedMoreThanHalf = self.sideMenuTrailingConstraint.constant > -(self.sideMenuRevealWidth * 0.5)
                self.sideMenuState(expanded: movedMoreThanHalf)
            }
            else {
                if let recogView = sender.view?.subviews[1] {
                    let movedMoreThanHalf = recogView.frame.origin.x > self.sideMenuRevealWidth * 0.5
                    self.sideMenuState(expanded: movedMoreThanHalf)
                }
            }
        default:
            break
        }
    }
}
