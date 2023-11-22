//
//  MapViewVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 23/08/22.
//

import UIKit
import MapKit


struct MapModel {
    var longitude =  String()
    var latitude =  String()
    var hotelname = String()
}


class MapViewVC: UIViewController {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var textFieldHolderView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var mapview: MKMapView!
    
    static var newInstance: MapViewVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? MapViewVC
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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        
        self.view.backgroundColor = .black.withAlphaComponent(0.4)
        self.holderView.backgroundColor = .WhiteColor
        nav.navtitle.isHidden = false
        setuplabels(lbl:  nav.navtitle, text: "Map View", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 20), align: .center)
        nav.backBtn.addTarget(self, action: #selector(backbtnAction(_:)), for: .touchUpInside)
        
        let screenHeight = UIScreen.main.bounds.size.height
        if screenHeight > 835 {
            navHeight.constant = 130
        }else {
            navHeight.constant = 100
        }
        
        textFieldHolderView.backgroundColor = HexColor("#F0F0F0")
        textFieldHolderView.layer.cornerRadius = 6
        textFieldHolderView.clipsToBounds = true
        searchImg.image = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
        searchTF.font = UIFont.OpenSansMedium(size: 16)
        searchTF.placeholder = "Search By Location"
        searchTF.setLeftPaddingPoints(20)
        searchTF.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    }
    
    @objc func backbtnAction(_ sender:UIButton) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    @objc func editingChanged(_ textField:UITextField) {
        print(textField.text)
    }
    
}
