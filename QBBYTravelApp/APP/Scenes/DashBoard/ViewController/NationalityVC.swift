//
//  NationalityVC.swift
//  HolidaysCenter
//
//  Created by FCI on 19/05/23.
//

import UIKit

class NationalityVC: BaseTableVC, AirlinesListVModelDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var searchTextfieldHolderView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var searchTF: UITextField!
    
    
    var airlinecodeArray = [String]()
    var airlineNameArray = [String]()
    
    var hotelFilterd:[Country_list]  = []
    var filtered:[Airline_list] = []
    var airlinelist:[Airline_list] = []
    var vm: AirlinesListVModel?
    var tablerow = [TableRow]()
    var titleStr = String()
    var payload = [String:Any]()
    var isSearchBool = Bool()
    var searchText = String()
    
    static var newInstance: NationalityVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? NationalityVC
        return vc
    }
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        
        if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if tabselect == "Airline" {
                navBar.titlelbl.text = "Airlines"
                callAPI()
            }else {
                navBar.titlelbl.text = "Nationality"
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = AirlinesListVModel(self)
    }
    
    
    func setupUI() {
        
        if screenHeight > 835 {
            navHeight.constant = 130
        }else {
            navHeight.constant = 110
        }
        
        
        holderView.backgroundColor = .AppHolderViewColor
       
        navBar.backBtn.addTarget(self, action: #selector(didTapOnBackButton(_:)), for: .touchUpInside)
        searchTextfieldHolderView.backgroundColor = HexColor("#E6E8E7")
        searchTextfieldHolderView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 6)
        searchImg.image = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
        searchTF.becomeFirstResponder()
        searchTF.backgroundColor = .clear
        searchTF.setLeftPaddingPoints(40)
        searchTF.font = UIFont.LatoRegular(size: 16)
        searchTF.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        commonTableView.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        commonTableView.separatorStyle = .singleLine
        commonTableView.separatorColor = .lightGray
        
    }
    
    
    @objc func didTapOnBackButton(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    @objc func searchTextChanged(_ sender: UITextField) {
        searchText = sender.text ?? ""
        
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
        }
        
    }
    
    
    
    func filterContentForSearchText(_ searchText: String) {
        
        
        if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if tabselect == "Airline" {
                filtered.removeAll()
                filtered = self.airlinelist.filter { thing in
                    return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
                }
                loadData(list: filtered)
            }else {
                hotelFilterd.removeAll()
                hotelFilterd = countrylist.filter { thing in
                    return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
                }
            }
        }
        
        commonTableView.reloadData()
    }
    
    
}

extension NationalityVC {
    
    
    func callAPI() {
        vm?.CALL_GET_AIRLINE_LIST_API(dictParam: [:])
    }
    
    
    func airlineList(response: AirlinesListModel) {
        airlinelist.removeAll()
        airlineNameArray.removeAll()
        airlinecodeArray.removeAll()
        
        airlinelist = response.airline_list ?? []
        loadData(list: airlinelist)
        
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    func loadData(list:[Airline_list]) {
        airlineNameArray.removeAll()
        airlinecodeArray.removeAll()
        
        airlineNameArray.append("ALL")
        airlinecodeArray.append("ALL")
        list.forEach { i in
            airlineNameArray.append(i.name ?? "")
            airlinecodeArray.append(i.code ?? "")
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //check search text & original text
        
        
        
        if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if tabselect == "Airline" {
                if( isSearchBool == true){
                    return airlineNameArray.count
                }else{
                    return airlineNameArray.count
                }
            }else {
                if( isSearchBool == true){
                    return hotelFilterd.count
                }else{
                    return countrylist.count
                }
                
                
            }
            
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TitleLblTVCell {
            cell.selectionStyle = .none
            
            
            
            if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect) {
                if tabselect == "Airline" {
                    
                    if( isSearchBool == true){
                        // let dict = filtered[indexPath.row]
                        cell.titlelbl.text = airlineNameArray[indexPath.row]
                        cell.airlinecode = airlinecodeArray[indexPath.row]
                    }else{
                        //  let dict = airlinelist[indexPath.row]
                        cell.titlelbl.text = airlineNameArray[indexPath.row]
                        cell.airlinecode = airlinecodeArray[indexPath.row]
                    }
                    
                }else {
                    
                    if( isSearchBool == true){
                        let dict = hotelFilterd[indexPath.row]
                        cell.titlelbl.text = dict.name
                        cell.airlinecode = dict.iso_country_code ?? ""
                    }else{
                        let dict = countrylist[indexPath.row]
                        cell.titlelbl.text = dict.name
                        cell.airlinecode = dict.iso_country_code ?? ""
                    }
                    
                }
            }
            
            ccell = cell
        }
        return ccell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? TitleLblTVCell {
            if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect) {
                if tabselect == "Airline" {
                    defaults.set(airlineNameArray[indexPath.row], forKey: UserDefaultsKeys.nationality)
                    defaults.set(airlinecodeArray[indexPath.row] , forKey: UserDefaultsKeys.airlinescode)
                }else {
                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.hnationality)
                    defaults.set(cell.airlinecode , forKey: UserDefaultsKeys.hnationalitycode)
                }
            }
        }
        
        
        
        NotificationCenter.default.post(name: NSNotification.Name("calreloadTV"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        self.dismiss(animated: true)
    }
    
    
}
