//
//  SaveTravellersDetailsVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 18/08/22.
//

import UIKit
import CoreData
import MaterialComponents


class SaveTravellersDetailsVC: BaseTableVC, GetMealsListViewModelDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    
    static var newInstance: SaveTravellersDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SaveTravellersDetailsVC
        return vc
    }
    
    
    var id = String()
    var tablerow = [TableRow]()
    var keyStr = String()
    var ptitle = String()
    var gender = String()
    var fname = String()
    var lname = String()
    var dob = String()
    var nationalitycode = String()
    var passportNO = String()
    var passportIssuingCountrycode = String()
    var issuingCountryName = String()
    var passportExprityDate = String()
    var countryCode = String()
    var nameTitle = String()
    var genderTitle = String()
    var vm:GetMealsListViewModel?
    var nationalityName = String()
    var passIssuingCountryName = String()
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        callAPI()
    }
    
    
    func callAPI() {
        DispatchQueue.main.async {[self] in
            vm?.CALL_GET_MEAL_LIST_API(dictParam: [:])
        }
    }
    
    
    func mealList(response: GetMealsListModel) {
        meallist = response.meal ?? []
        DispatchQueue.main.async {[self] in
            vm?.CALL_GET_special_Assistance_list_API(dictParam: [:])
        }
    }
    
    func specialAssistancelist(response: GetMealsListModel) {
        specialAssistancelist1 = response.meal ?? []
        DispatchQueue.main.async {[self] in
            if keyStr == "edit" {
                fetchCoreDataValues()
            }else {
                setupTVCells()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        vm = GetMealsListViewModel(self)
    }
    
    
    
    func setupUI() {
        
        holderView.backgroundColor = .AppHolderViewColor
        
        setuplabels(lbl:  nav.navtitle, text: "Travellers Details", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 20), align: .center)
        
        nav.backBtn.addTarget(self, action: #selector(gotoBackScreen), for: .touchUpInside)
        nav.citylbl.isHidden = false
        nav.navtitle.isHidden = false
        
        setuplabels(lbl:  nav.citylbl, text: self.ptitle.uppercased(), textcolor: .AppLabelColor, font: .OpenSansMedium(size: 14), align: .center)
        
        //        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.tabselect){
        //            if selectedTab == "Airline" {
        //
        //                setuplabels(lbl:  nav.citylbl, text: self.ptitle.uppercased(), textcolor: .AppLabelColor, font: .OpenSansMedium(size: 14), align: .center)
        //            }else {
        //
        //                if ptitle == "AD" {
        //                    setuplabels(lbl:  nav.citylbl, text: "ADULT", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 14), align: .center)
        //
        //                }else {
        //
        //                    setuplabels(lbl:  nav.citylbl, text: "CHILD", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 14), align: .center)
        //
        //                }
        //            }
        //
        //        }
        
        commonTableView.backgroundColor = .AppHolderViewColor
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "SaveTravellerDetailsTVCell"])
        
        
    }
    
    
    @objc func gotoBackScreen() {
        dismiss(animated: true)
    }
    
    
    func setupTVCells() {
        tablerow.removeAll()
        tablerow.append(TableRow(key:keyStr,cellType:.SaveTravellerDetailsTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    override func didTapOnMrBtnAction(cell: SaveTravellerDetailsTVCell) {
        gender = "Male"
        genderTitle = "1"
        cell.mrRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#254179"))
        cell.mrsRadioImg.image = UIImage(named: "radioUnselected")
        cell.missRadioImg.image = UIImage(named: "radioUnselected")
        
    }
    
    override func didTapOnMrsBtnAction(cell: SaveTravellerDetailsTVCell) {
        gender = "Female"
        genderTitle = "2"
        cell.mrRadioImg.image = UIImage(named: "radioUnselected")
        cell.mrsRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#254179"))
        cell.missRadioImg.image = UIImage(named: "radioUnselected")
    }
    
    override func didTapOnMissBtnAction(cell: SaveTravellerDetailsTVCell) {
        gender = "Others"
        genderTitle = "3"
        cell.mrRadioImg.image = UIImage(named: "radioUnselected")
        cell.mrsRadioImg.image = UIImage(named: "radioUnselected")
        cell.missRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#254179"))
    }
    
    
    
    override func editingMDCOutlinedTextField(tf: MDCOutlinedTextField) {
        switch tf.tag {
            
        case 1:
            fname = tf.text ?? ""
            break
            
        case 2:
            lname = tf.text ?? ""
            break
            
        case 5:
            passportNO = tf.text ?? ""
            break
            
            
            
        default:
            break
        }
    }
    
    
    func showErrorMessage(item:Int,msg:String) {
        let cell = commonTableView.cellForRow(at: IndexPath(item: item, section: 0)) as? TextfieldTVCell
        cell?.txtField.setOutlineColor( .red.withAlphaComponent(0.4) , for: .disabled)
        showToast(message: msg)
    }
    
    
    func gotoPayNowVC() {
        guard let vc = PayNowVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    
    override func donedatePicker(cell:SaveTravellerDetailsTVCell){
        if cell.dobTF.isFirstResponder {
            dob = cell.dobTF.text ?? ""
        } else if cell.passportExpireDateTF.isFirstResponder {
            passportExprityDate = cell.passportExpireDateTF.text ?? ""
        }
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell:SaveTravellerDetailsTVCell){
        self.view.endEditing(true)
    }
    
    override func didTapOnSelectNationalityBtn(cell:SaveTravellerDetailsTVCell){
        nationalitycode = cell.natinalityCode
        countryCode = cell.countryCode
        //   nationalityName = cell.nationalityName
    }
    override func didTapOnSelectIssuingCountryBtn(cell:SaveTravellerDetailsTVCell){
        passportIssuingCountrycode = cell.isssuingCountryCode
        //   passIssuingCountryName = cell.passIssuingCountryName
    }
    
    
    
    override func didTapOnTitleBtnAction(cell:SaveTravellerDetailsTVCell) {
        if cell.titleTF.text == "MR" {
            nameTitle = "1"
        }else if cell.titleTF.text == "MS" {
            nameTitle = "2"
        }else if cell.titleTF.text == "MRS" {
            nameTitle = "3"
        }else {
            nameTitle = "1"
        }
    }
    
    
    override func didTapOnMealPreferenceBtn(cell:SaveTravellerDetailsTVCell){
        print(cell.mealPreferenceTF.text)
    }
    
    override func didTapOnSpecialAssicintenceBtn(cell:SaveTravellerDetailsTVCell){
        print(cell.specialAssicintenceTF.text)
    }
    
    
    
    override func didTapOnSaveTravellerDetailsBtnAction(cell: SaveTravellerDetailsTVCell) {
        
        if gender.isEmpty == true {
            showErrorMessage(item: 3, msg: "Enter Gender")
        }else if fname.isEmpty == true {
            showErrorMessage(item: 3, msg: "Enter First Name")
        }else if lname.isEmpty == true {
            showErrorMessage(item: 4, msg: "Enter Last Name")
        }else if dob.isEmpty == true {
            showErrorMessage(item: 5, msg: "Enter DOB")
        }else if passportNO.isEmpty == true {
            showErrorMessage(item: 6, msg: "Enter Passport NO")
        }else if passportIssuingCountrycode.isEmpty == true {
            showErrorMessage(item: 7, msg: "Enter Passport Issuing Country")
        }else if passportExprityDate.isEmpty == true {
            showErrorMessage(item: 8, msg: "Enter Passport Exprity Date")
        }else {
            
            
            if keyStr == "edit" {
                DispatchQueue.main.async {
                    self.update()
                }
            }else {
                DispatchQueue.main.async {
                    self.saveDetailsLocally()
                }
            }
            
        }
    }
    
    
    //MARK: -  saveDetailsLocally
    func saveDetailsLocally() {
        
        let rno = Int.random(in: 0...500)
        
        let entity = NSEntityDescription.entity(forEntityName: "PassengerDetails", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue("\(rno)", forKey: "id")
        newUser.setValue(ptitle, forKey: "title")
        newUser.setValue(nameTitle, forKey: "nameTitle")
        newUser.setValue(genderTitle, forKey: "genderTitle")
        newUser.setValue(gender, forKey: "gender")
        newUser.setValue(fname, forKey: "fname")
        newUser.setValue(lname, forKey: "lname")
        newUser.setValue(dob, forKey: "dob")
        newUser.setValue(passportNO, forKey: "passportno")
        newUser.setValue(passportExprityDate, forKey: "passportexpirydate")
        newUser.setValue(passportIssuingCountrycode, forKey: "issuingCountryCode")
        newUser.setValue(countryCode, forKey: "countryCode")
        newUser.setValue(nationalitycode, forKey: "nationalitycode")
        newUser.setValue(nationalityName, forKey: "nationalityName")
        newUser.setValue(passIssuingCountryName, forKey: "passIssuingCountryName")
        
        
        do {
            try context.save()
            showToast(message: "saveDetailsLocally")
        } catch {
            print("Error saving")
        }
        
        
        callapibool = true
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        dismiss(animated: true)
        
    }
    
    
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchCoreDataValues() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        request.predicate = NSPredicate(format: "id = %@", id)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            print(result)
            travellerdetails = result
            
            for data in result as! [NSManagedObject]{
                
                ptitle = (data.value(forKey: "title") as? String) ?? ""
                nameTitle = (data.value(forKey: "nameTitle") as? String) ?? ""
                genderTitle = (data.value(forKey: "genderTitle") as? String) ?? ""
                gender = (data.value(forKey: "gender") as? String) ?? ""
                fname = (data.value(forKey: "fname") as? String) ?? ""
                lname = (data.value(forKey: "lname") as? String) ?? ""
                dob = (data.value(forKey: "dob") as? String) ?? ""
                passportNO = (data.value(forKey: "passportno") as? String) ?? ""
                nationalitycode = (data.value(forKey: "nationalitycode") as? String) ?? ""
                passportExprityDate = (data.value(forKey: "passportexpirydate") as? String) ?? ""
                passportIssuingCountrycode = (data.value(forKey: "issuingCountryCode") as? String) ?? ""
                countryCode = (data.value(forKey: "countryCode") as? String) ?? ""
                nationalityName = (data.value(forKey: "nationalityName") as? String) ?? ""
                passIssuingCountryName = (data.value(forKey: "passIssuingCountryName") as? String) ?? ""
                
            }
            
            DispatchQueue.main.async {[self] in
                setupTVCells()
            }
        } catch {
            print("Failed")
        }
    }
    
    
    
    
    
    
    //MARK: - UPDATING COREDATA VALUES
    
    func update(){
        
        let entity = NSEntityDescription.entity(forEntityName: "PassengerDetails", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        let predicate = NSPredicate(format: "(id = %@)", id)
        request.predicate = predicate
        do {
            let results = try context.fetch(request)
            let newUser = results[0] as! NSManagedObject
            
            newUser.setValue(ptitle, forKey: "title")
            newUser.setValue(nameTitle, forKey: "nameTitle")
            newUser.setValue(genderTitle, forKey: "genderTitle")
            newUser.setValue(gender, forKey: "gender")
            newUser.setValue(fname, forKey: "fname")
            newUser.setValue(lname, forKey: "lname")
            newUser.setValue(dob, forKey: "dob")
            newUser.setValue(passportNO, forKey: "passportno")
            newUser.setValue(nationalitycode, forKey: "nationalitycode")
            newUser.setValue(passportExprityDate, forKey: "passportexpirydate")
            newUser.setValue(passportIssuingCountrycode, forKey: "issuingCountryCode")
            newUser.setValue(countryCode, forKey: "countryCode")
            newUser.setValue(nationalitycode, forKey: "nationalitycode")
            newUser.setValue(nationalityName, forKey: "nationalityName")
            newUser.setValue(passIssuingCountryName, forKey: "passIssuingCountryName")
            
            do {
                try context.save()
                
            }catch let _ as NSError {
                print("Failed")
            }
        }catch let _ as NSError {
            print("Failed")
        }
        
        callapibool = true
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        dismiss(animated: true)
        
    }
    
    
}
