//
//  SelectFromCityVC.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit
import Alamofire


class SelectFromCityVC: BaseTableVC, SelectCityViewModelProtocal {
   
    @IBOutlet weak var searchTextfieldHolderView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var nav: NavBar!
    
    var filtered1:[CityOrHotelListModel] = []
    var cityList1:[CityOrHotelListModel] = []
   
    var filtered:[SelectCityModel] = []
    var cityList:[SelectCityModel] = []
    
    var holidayfiltered:[HolidayCitySearchModel] = []
    var holidaycityList:[HolidayCitySearchModel] = []
    
    var keyStr = String()
    var cityViewModel: SelectCityViewModel?
    var tablerow = [TableRow]()
    var titleStr = String()
    var payload = [String:Any]()
    var isSearchBool = Bool()
    var searchText = String()
    static var newInstance: SelectFromCityVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectFromCityVC
        return vc
    }
    
    var celltag = Int()
    
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        self.celltag = Int(defaults.string(forKey: UserDefaultsKeys.cellTag) ?? "0") ?? 0
        searchTF.becomeFirstResponder()
        
        if keyStr == "holiday" {
            callHolidayCitySearchListAPI(str: "")
        }else if keyStr == "hotel" {
            CallShowHotelorCityListAPI(str: "")
        }else {
            CallShowCityListAPI(str: "")
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV(notification:)), name: NSNotification.Name("reloadTV"), object: nil)
    }
    
    
    
    @objc func reloadTV(notification:NSNotification) {
        if keyStr == "holiday" {
            callHolidayCitySearchListAPI(str: "")
        }else if keyStr == "hotel" {
            CallShowHotelorCityListAPI(str: "")
        }else {
            CallShowCityListAPI(str: "")
        }
    }
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        cityViewModel = SelectCityViewModel(self)
        
    }
    
    func setupUI() {
        
        
        if keyStr == "holiday" {
            searchTF.placeholder = "search hotel/city"
        }else if keyStr == "hotel" {
            searchTF.placeholder = "search hotel/city"
        }else {
            searchTF.placeholder = "search airport /city"
        }

        nav.navtitle.isHidden = false
        nav.titlelbl.isHidden = true
        setuplabels(lbl: nav.navtitle, text: titleStr, textcolor: .AppLabelColor, font: .poppinsRegular(size: 16), align: .center)
        nav.backBtn.addTarget(self, action: #selector(dismisVC(_:)), for: .touchUpInside)
        setupViews(v: searchTextfieldHolderView, radius: 6, color: .WhiteColor.withAlphaComponent(0.5))
        
        searchImg.image = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
        searchTF.backgroundColor = .clear
        searchTF.setLeftPaddingPoints(20)
        searchTF.font = UIFont.LatoRegular(size: 16)
        searchTF.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        commonTableView.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        commonTableView.separatorStyle = .singleLine
        commonTableView.separatorColor = .lightGray
    }
    
    
    
    @objc func dismisVC(_ sender:UIButton) {
        self.dismiss(animated: true)
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    @objc func searchTextChanged(_ sender: UITextField) {
        searchText = sender.text ?? ""
        
        
        if keyStr == "holiday" {
            if searchText == "" {
                isSearchBool = false
                filterContentForSearchText(searchText)
            }else {
                isSearchBool = true
                filterContentForSearchText(searchText)
            }
            
            callHolidayCitySearchListAPI(str: searchText)
        }else if keyStr == "hotel" {
            
            if searchText == "" {
                isSearchBool = false
                filterContentForSearchText(searchText)
            }else {
                isSearchBool = true
                filterContentForSearchText(searchText)
            }
            
            CallShowHotelorCityListAPI(str: searchText)
        }else {
            if searchText == "" {
                isSearchBool = false
                filterContentForSearchText(searchText)
            }else {
                isSearchBool = true
                filterContentForSearchText(searchText)
            }
            
            CallShowCityListAPI(str: searchText)
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        if keyStr == "holiday" {
            holidayfiltered.removeAll()
            holidayfiltered = self.holidaycityList.filter { thing in
                return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
            }
        }else if keyStr == "hotel" {
            filtered1.removeAll()
            filtered1 = self.cityList1.filter { thing in
                return "\(thing.label?.lowercased() ?? "")".contains(searchText.lowercased())
            }
        }else {
            filtered.removeAll()
            filtered = self.cityList.filter { thing in
                return "\(thing.label?.lowercased() ?? "")".contains(searchText.lowercased())
            }
        }
        
        commonTableView.reloadData()
    }
    
    
    func CallShowCityListAPI(str:String) {
        payload["term"] = str
        cityViewModel?.CallShowCityListAPI(dictParam: payload)
    }
    
    func CallShowHotelorCityListAPI(str:String) {
        payload["term"] = str
        cityViewModel?.CALL_GET_HOTEL_CITY_LIST_API(dictParam: payload)
    }
    
    func callHolidayCitySearchListAPI(str:String) {
        payload["term"] = str
        cityViewModel?.CALL_GET_HOLIDAY_CITY_LIST_API(dictParam: payload)
    }
    
    
    
    func ShowCityList(response: [SelectCityModel]) {
        self.cityList = response
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    func getHotelCityList(response: [CityOrHotelListModel]) {
        self.cityList1 = response
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    func getHolidayCityList(response: [HolidayCitySearchModel]) {
        self.holidaycityList = response
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    
    
    
    func gotoBookFlightVC() {
        guard let vc = BookFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func gotoSearchHotelsVC() {
        guard let vc = BookHotelVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}


extension SelectFromCityVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //check search text & original text
        if keyStr == "holiday" {
            if(isSearchBool == true){
                return holidayfiltered.count
            }else{
                return holidaycityList.count
            }
        }else if keyStr == "hotel" {
            if(isSearchBool == true){
                return filtered1.count
            }else{
                return cityList1.count
            }
        }else {
            if( isSearchBool == true){
                return filtered.count
            }else{
                return cityList.count
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FromCityTVCell
        cell.selectionStyle = .none
        if keyStr == "holiday" {
            
            if( isSearchBool == true){
                let dict = holidayfiltered[indexPath.row]
                cell.titlelbl.text = dict.name
                cell.id = dict.id ?? ""
                cell.cityname = dict.value ?? ""
                cell.setAttributedString(str1: dict.value ?? "", str2: "")
                cell.plainImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#254179"))

            }else{
                let dict = holidaycityList[indexPath.row]
                cell.titlelbl.text = dict.value
                cell.id = dict.id ?? ""
                cell.cityname = dict.value ?? ""
                cell.setAttributedString(str1: dict.value ?? "", str2: "")
                cell.plainImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#254179"))

            }
            
            
        }else if keyStr == "hotel" {
            if( isSearchBool == true){
                let dict = filtered1[indexPath.row]
                cell.titlelbl.text = dict.value
                cell.id = dict.id ?? ""
                cell.cityname = dict.label ?? ""
                cell.setAttributedString(str1: dict.value ?? "", str2: "")
                cell.plainImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#254179"))

            }else{
                let dict = cityList1[indexPath.row]
                cell.titlelbl.text = dict.value
                cell.id = dict.id ?? ""
                cell.cityname = dict.label ?? ""
                cell.setAttributedString(str1: dict.value ?? "", str2: "")
                cell.plainImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#254179"))

            }
        }else {
            if( isSearchBool == true){
                let dict = filtered[indexPath.row]
                cell.titlelbl.text = dict.airport_city
                cell.label = dict.label ?? ""
                cell.id = dict.id ?? ""
                cell.cityname = "\(dict.airport_city ?? "") (\(dict.airport_code ?? ""))"
                cell.setAttributedString(str1: dict.airport_name ?? "", str2: " \(dict.airport_code ?? "")")
                cell.plainImg.image = UIImage(named: "flight")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#254179"))
                cell.cityCode = dict.airport_code ?? ""
            }else{
                let dict = cityList[indexPath.row]
                cell.titlelbl.text = dict.airport_city
                cell.label = dict.label ?? ""
                cell.id = dict.id ?? ""
                cell.cityname = "\(dict.airport_city ?? "") (\(dict.airport_code ?? ""))"
                cell.setAttributedString(str1: dict.airport_name ?? "", str2: " \(dict.airport_code ?? "")")
                cell.plainImg.image = UIImage(named: "flight")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#254179"))
                cell.cityCode = dict.airport_code ?? ""

            }
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? FromCityTVCell {
            
            if let selectedtab = defaults.string(forKey: UserDefaultsKeys.tabselect) {
                if selectedtab == "Airline" {
                    if let selectedJourneyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                        if selectedJourneyType == "oneway" {
                            if titleStr == "From" {
                                defaults.set(cell.label , forKey: UserDefaultsKeys.fromCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.fromlocid)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.fromcityname)
                            }else {
                                defaults.set(cell.label , forKey: UserDefaultsKeys.toCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.tolocid)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.tocityname)
                                
                            }
                        }else if selectedJourneyType == "circle" {
                            if titleStr == "From" {
                                defaults.set(cell.label, forKey: UserDefaultsKeys.fromCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.fromlocid)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.fromcityname)
                            }else {
                                defaults.set(cell.label, forKey: UserDefaultsKeys.toCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.tolocid)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.tocityname)
                            }
                        }else {
                            if titleStr == "From" {
                                defaults.set(cell.label, forKey: UserDefaultsKeys.mfromCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.mfromlocid)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.mfromcityname)
                                
                                
                                fromCityCodeArray[self.celltag] = cell.cityCode
                                fromCityNameArray[self.celltag] = cell.label
                                fromlocidArray[self.celltag] = cell.id
                                
                            }else {
                                defaults.set(cell.label, forKey: UserDefaultsKeys.mtoCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.mtolocid)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.mtocityname)
                                
                                toCitycodeArray[self.celltag] = cell.cityCode
                                toCityNameArray[self.celltag] = cell.label
                                tolocidArray[self.celltag] = cell.id
                                
                            }
                        }
                    }
                    
                    
                    
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                    dismiss(animated: true)
                }else if selectedtab == "Holiday" {
                    
                    
                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.holidaylocationcity)
                    defaults.set(cell.id , forKey: UserDefaultsKeys.holidaylocationid)
                    
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                    self.dismiss(animated: true)
                    
                    
                }else {
                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.locationcity)
                    defaults.set(cell.id , forKey: UserDefaultsKeys.locationid)
                    
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                    self.dismiss(animated: true)
                }
            }
        }
        
        
    }
}
