//
//  LoadWebViewVC.swift
//  AlghanimTravelApp
//
//  Created by FCI on 29/09/22.
//

import UIKit
import WebKit
import SwiftyJSON

class LoadWebViewVC: UIViewController, ConfirmTicketViewmodelDelegate, TimerManagerDelegate {
    func timerDidFinish() {
        
    }
    
    func updateTimer() {
        
    }
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    
    static var newInstance: LoadWebViewVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? LoadWebViewVC
        return vc
    }
    
    
    var urlString = String()
    var titleString = String()
    var apicallbool = true
    var isVcFrom = String()
    var vm:ConfirmTicketViewmodel?
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        //loderBool = false
        
        print("<<<<<<<=== urlString ==>>>>>>\n \(urlString)")
        if let url1 = URL(string: urlString) {
            webview.load(URLRequest(url: url1))
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: NSNotification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadscreen), name: NSNotification.Name("reloadscreen"), object: nil)
        
    }
    
    
    
    
    //MARK: - nointernet
    
    @objc func nointernet(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    @objc func reloadscreen(){
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        vm = ConfirmTicketViewmodel(self)
        TimerManager.shared.delegate = self
    }
    
    
    func setupUI() {
      
        holderView.backgroundColor = .WhiteColor
        nav.backgroundColor = .AppHolderViewColor
        nav.navtitle.isHidden = false
        

        if isVcFrom == "voucher" {
            setuplabels(lbl:  nav.navtitle, text: "Voucher Details", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 20), align: .center)
        }else {
            setuplabels(lbl:  nav.navtitle, text: "Payment", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 20), align: .center)

        }
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        webview.navigationDelegate = self
        webview.isUserInteractionEnabled = true
        
    }
    
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        if isVcFrom == "voucher" {
            callapibool = false
            dismiss(animated: true)
        }else {
            gotoDashBoardTabbarVC()
        }
    }
    
    
    
    
    func callConformTicketApi(urlstr:String){
        BASE_URL = ""
        vm?.CALL_HOME_PAGE_DETAILS_API(dictParam: [:], url: urlstr)
    }
    
    func cfdetails(response: ConformTicketModel) {
        TimerManager.shared.stopTimer()
        BASE_URL = BASE_URL1
        guard let vc = BookingConfirmedVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.urlString = response.url ?? ""
        callapibool = true
        present(vc, animated: true)
        
    }
    
    
    
    
    func gotoDashBoardTabbarVC() {
        TimerManager.shared.stopTimer()
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        callapibool = true
        present(vc, animated: true)
    }
    
    
}



extension LoadWebViewVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let response = navigationResponse.response as? HTTPURLResponse {
            print(" ======== response =====")
            print(response)
            
            if response.statusCode == 200 {
                
            }
            
        }
        decisionHandler(.allow)
    }
    
    
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        debugPrint("didCommit")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
        let str = webView.url?.absoluteString ?? ""
        
        if apicallbool == false {
            
            if str.containsIgnoringCase(find: "paymentcancel") || str.containsIgnoringCase(find: "CANCELED") || str.containsIgnoringCase(find: "bookingFailuer"){
                
                showAlertOnWindow(title: "",message: "Somthing Went Wrong",titles: ["OK"]) { title in
                    self.gotoDashBoardTabbarVC()
                }
            }else {
                
                if str.contains(find: "confirm_ticketing") {
                    callConformTicketApi(urlstr: webView.url?.absoluteString ?? "")
                }
                
            }
        }
        apicallbool = false
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugPrint("didFail")
    }
    
    
}

extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}

