//
//  SaveTravellerDetailsTVCell.swift
//  QBBYTravelApp
//
//  Created by FCI on 19/04/23.
//

import UIKit
import MaterialComponents
import DropDown
import CoreData

enum AgeCategory {
    case adult
    case child
    case infant
}


protocol SaveTravellerDetailsTVCellDelegate {
    
    func didTapOnTitleBtnAction(cell:SaveTravellerDetailsTVCell)
    func didTapOnMrBtnAction(cell:SaveTravellerDetailsTVCell)
    func didTapOnMrsBtnAction(cell:SaveTravellerDetailsTVCell)
    func didTapOnMissBtnAction(cell:SaveTravellerDetailsTVCell)
    func didTapOnSaveTravellerDetailsBtnAction(cell:SaveTravellerDetailsTVCell)
    func editingMDCOutlinedTextField(tf:MDCOutlinedTextField)
    func donedatePicker(cell:SaveTravellerDetailsTVCell)
    func cancelDatePicker(cell:SaveTravellerDetailsTVCell)
    func didTapOnSelectNationalityBtn(cell:SaveTravellerDetailsTVCell)
    func didTapOnSelectIssuingCountryBtn(cell:SaveTravellerDetailsTVCell)
    func didTapOnMealPreferenceBtn(cell:SaveTravellerDetailsTVCell)
    func didTapOnSpecialAssicintenceBtn(cell:SaveTravellerDetailsTVCell)
    
}

class SaveTravellerDetailsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var mrRadioImg: UIImageView!
    @IBOutlet weak var mrlbl: UILabel!
    @IBOutlet weak var mrBtn: UIButton!
    @IBOutlet weak var mrsRadioImg: UIImageView!
    @IBOutlet weak var mrslbl: UILabel!
    @IBOutlet weak var mrsBtn: UIButton!
    @IBOutlet weak var missRadioImg: UIImageView!
    @IBOutlet weak var misslbl: UILabel!
    @IBOutlet weak var missBtn: UIButton!
    @IBOutlet weak var fnameTF: MDCOutlinedTextField!
    @IBOutlet weak var lnameTF: MDCOutlinedTextField!
    @IBOutlet weak var dobTF: MDCOutlinedTextField!
    @IBOutlet weak var nationalityTF: MDCOutlinedTextField!
    @IBOutlet weak var passportnoTF: MDCOutlinedTextField!
    @IBOutlet weak var passportIssuingCountryTF: MDCOutlinedTextField!
    @IBOutlet weak var passportExpireDateTF: MDCOutlinedTextField!
    @IBOutlet weak var saveBtnView: UIView!
    @IBOutlet weak var savelbl: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleViewWidth: NSLayoutConstraint!
    @IBOutlet weak var titleTF: MDCOutlinedTextField!
    
    @IBOutlet weak var nameTitleSelectBtn: UIButton!
    @IBOutlet weak var passportNationalitySelectBtn: UIButton!
    @IBOutlet weak var passportIssueingCountrySelectBtn: UIButton!
    
    @IBOutlet weak var frequentFlyrPgmTF: MDCOutlinedTextField!
    @IBOutlet weak var frequentFlyrPgmBtn: UIButton!
    @IBOutlet weak var frequentFlyrNoTF: MDCOutlinedTextField!
    @IBOutlet weak var mealPreferenceTF: MDCOutlinedTextField!
    @IBOutlet weak var mealPreferenceBtn: UIButton!
    @IBOutlet weak var specialAssicintenceTF: MDCOutlinedTextField!
    @IBOutlet weak var specialAssicintenceBtn: UIButton!
    @IBOutlet weak var othersGenderView: UIView!
    
    let dobDatePicker = UIDatePicker()
    let passportDatePicker = UIDatePicker()
    let dropDown = DropDown()
    let dropDown1 = DropDown()
    let mealsDropdown = DropDown()
    let specialAssistenceDropDown = DropDown()
    let titledropDown = DropDown()
    var clist = [Country_list]()
    var countryNames = [String]()
    var natinalityCode = String()
    var countryCode = String()
    var isssuingCountryCode = String()
    var maxLength = 50
    var delegate:SaveTravellerDetailsTVCellDelegate?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state radioSelected
    }
    
    
    override func updateUI() {
        
        clist = countrylist
        countrylist.forEach { i in
            countryNames.append(i.name ?? "")
        }
        DispatchQueue.main.async {[self] in
            dropDown1.dataSource = countryNames
            dropDown.dataSource = countryNames
        }
        
        if cellInfo?.key == "edit" {
            
            for data in travellerdetails as! [NSManagedObject]{
                
                var ptitle = (data.value(forKey: "title") as? String) ?? ""
                var nameTitle = (data.value(forKey: "nameTitle") as? String) ?? ""
                let gender = (data.value(forKey: "gender") as? String) ?? ""
                fnameTF.text = (data.value(forKey: "fname") as? String) ?? ""
                lnameTF.text = (data.value(forKey: "lname") as? String) ?? ""
                dobTF.text = (data.value(forKey: "dob") as? String) ?? ""
                passportnoTF.text = (data.value(forKey: "passportno") as? String) ?? ""
                nationalityTF.text = (data.value(forKey: "nationalitycode") as? String) ?? ""
                passportExpireDateTF.text = (data.value(forKey: "passportexpirydate") as? String) ?? ""
                passportIssuingCountryTF.text = (data.value(forKey: "issuingCountryCode") as? String) ?? ""
                var countryCode = (data.value(forKey: "countryCode") as? String) ?? ""
                
                
                if gender == "Male" {
                    setupMale()
                }else if gender == "Female" {
                    setupFeMale()
                }else {
                    setupOthersGender()
                }
                
                
                if nameTitle == "1" {
                    self.titleTF.text = "MR"
                }else if nameTitle == "2" {
                    self.titleTF.text = "MS"
                }else {
                    self.titleTF.text = "MRS"
                }
            }
        }
        
        
        
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        mrRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        mrsRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        missRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        setuplabels(lbl: mrlbl, text: "Male", textcolor: .AppLabelColor, font: .OpenSansBold(size: 14), align: .left)
        setuplabels(lbl: mrslbl, text: "Female", textcolor: .AppLabelColor, font: .OpenSansBold(size: 14), align: .left)
        setuplabels(lbl: misslbl, text: "Others", textcolor: .AppLabelColor, font: .OpenSansBold(size: 14), align: .left)
        mrBtn.setTitle("", for: .normal)
        mrsBtn.setTitle("", for: .normal)
        missBtn.setTitle("", for: .normal)
        
        setupTextField(txtField: titleTF, tag1: 1, label: "Title*", placeholder: "MR")
        setupTextField(txtField: fnameTF, tag1: 1, label: "First Name*", placeholder: "Enter First Name")
        setupTextField(txtField: lnameTF, tag1: 2, label: "Last Name*", placeholder: "Enter Last Name")
        setupTextField(txtField: dobTF, tag1: 3, label: "Date of Birth*", placeholder: "Select DOB")
        setupTextField(txtField: nationalityTF, tag1: 4, label: "Nationality*", placeholder: "Select Nationality")
        setupTextField(txtField: passportnoTF, tag1: 5, label: "Passport NO*", placeholder: "Enter Passport NO")
        setupTextField(txtField: passportIssuingCountryTF, tag1: 6, label: "Passport Issuing Country*", placeholder: "Select Country")
        setupTextField(txtField: passportExpireDateTF, tag1: 7, label: "Passport Exprity Date*", placeholder: "Select Date")
        
        setupTextField(txtField: frequentFlyrPgmTF, tag1: 8, label: "Frequent Flyer Program", placeholder: "Select")
        setupTextField(txtField: frequentFlyrNoTF, tag1: 9, label: "Frequent Flyer Number", placeholder: "Frequent Flyer Number")
        setupTextField(txtField: mealPreferenceTF, tag1: 10, label: "Meal Preferences (Optional)", placeholder: "Select")
        setupTextField(txtField: specialAssicintenceTF, tag1: 11, label: "Special Assistance(Optional)", placeholder: "Select")
        
        saveBtnView.backgroundColor = HexColor("#EEC646")
        saveBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 20)
        setuplabels(lbl: savelbl, text: "Save", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 16), align: .center)
        saveBtn.setTitle("", for: .normal)
        
        nameTitleSelectBtn.setTitle("", for: .normal)
        passportNationalitySelectBtn.setTitle("", for: .normal)
        passportIssueingCountrySelectBtn.setTitle("", for: .normal)
        frequentFlyrPgmBtn.setTitle("", for: .normal)
        mealPreferenceBtn.setTitle("", for: .normal)
        specialAssicintenceBtn.setTitle("", for: .normal)
        
        
        nameTitleSelectBtn.addTarget(self, action: #selector(didTapOnSelectNameTitle(_:)), for: .touchUpInside)
        passportNationalitySelectBtn.addTarget(self, action: #selector(didTapOnPassportNationalitySelectBtnAction(_:)), for: .touchUpInside)
        passportIssueingCountrySelectBtn.addTarget(self, action: #selector(didTapOnPassportIssuingCountrySelectBtnAction(_:)), for: .touchUpInside)
        
        frequentFlyrPgmBtn.addTarget(self, action: #selector(didTapOnFrequentFlyrPgmBtn(_:)), for: .touchUpInside)
        mealPreferenceBtn.addTarget(self, action: #selector(didTapOnMealPreferenceBtn(_:)), for: .touchUpInside)
        specialAssicintenceBtn.addTarget(self, action: #selector(didTapOnSpecialAssicintenceBtn(_:)), for: .touchUpInside)
        
        othersGenderView.isHidden = true
        
        
        showdobDatePicker()
        showexpirDatePicker()
        setupTitleDropDown()
        setupDropDown()
        setupIssuingCountryDropDown()
        setupDropdownforSpecialAssicintence()
        setupDropdownforMeallist()
        
    }
    
    
    @objc func didTapOnSelectNameTitle(_ sender:UIButton) {
        titledropDown.show()
    }
    
    @objc func didTapOnPassportIssuingCountrySelectBtnAction(_ sender:UIButton) {
        dropDown1.show()
    }
    
    @objc func didTapOnPassportNationalitySelectBtnAction(_ sender:UIButton) {
        dropDown.show()
    }
    
    
    @objc func didTapOnFrequentFlyrPgmBtn(_ sender:UIButton) {
        print("didTapOnFrequentFlyrPgmBtn")
    }
    
    @objc func didTapOnMealPreferenceBtn(_ sender:UIButton) {
        mealsDropdown.show()
    }
    
    @objc func didTapOnSpecialAssicintenceBtn(_ sender:UIButton) {
        specialAssistenceDropDown.show()
    }
    
    
    
    func setupTextField(txtField:MDCOutlinedTextField,tag1:Int,label:String,placeholder:String) {
        txtField.delegate = self
        txtField.tag = tag1
        txtField.label.text = label
        txtField.placeholder = placeholder
        txtField.backgroundColor = .clear
        txtField.font = UIFont.LatoRegular(size: 14)
        txtField.addTarget(self, action: #selector(editingMDCOutlinedTextField(textField:)), for: .editingChanged)
        txtField.label.textColor = .SubTitleColor
        txtField.setOutlineColor( .black, for: .editing)
        txtField.setOutlineColor( .red , for: .disabled)
        txtField.setOutlineColor( .lightGray.withAlphaComponent(0.4) , for: .normal)
    }
    
    
    
    func setupTitleDropDown() {
        
        titledropDown.direction = .any
        titledropDown.backgroundColor = .WhiteColor
        titledropDown.anchorView = self.titleView
        titledropDown.dataSource = ["MR","MS","MRS"]
        titledropDown.bottomOffset = CGPoint(x: 0, y: titleView.frame.size.height + 20)
        titledropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.titleTF.text = item
            self?.titleTF.resignFirstResponder()
            self?.delegate?.didTapOnTitleBtnAction(cell: self!)
        }
        
    }
    
    
    func setupDropDown() {
        
        dropDown.direction = .any
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.nationalityTF
        dropDown.bottomOffset = CGPoint(x: 0, y: nationalityTF.frame.size.height + 20)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.nationalityTF.text = item
            self?.nationalityTF.resignFirstResponder()
            self?.natinalityCode = self?.clist[index].origin ?? ""
            self?.countryCode = self?.clist[index].iso_country_code ?? ""
            self?.delegate?.didTapOnSelectNationalityBtn(cell: self!)
        }
        
    }
    
    
    func setupIssuingCountryDropDown() {
        
        dropDown1.direction = .any
        dropDown1.backgroundColor = .WhiteColor
        dropDown1.anchorView = self.passportIssuingCountryTF
        dropDown1.bottomOffset = CGPoint(x: 0, y: passportIssuingCountryTF.frame.size.height + 20)
        dropDown1.selectionAction = { [weak self] (index: Int, item: String) in
            self?.passportIssuingCountryTF.text = item
            self?.passportIssuingCountryTF.resignFirstResponder()
            self?.isssuingCountryCode = self?.clist[index].origin ?? ""
            self?.delegate?.didTapOnSelectIssuingCountryBtn(cell: self!)
        }
        
    }
    
    
    func setupDropdownforMeallist() {
        var mealnameArray = [String]()
        meallist.forEach { i in
            mealnameArray.append(i.description ?? "")
        }
        mealsDropdown.dataSource = mealnameArray
        mealsDropdown.direction = .any
        mealsDropdown.backgroundColor = .WhiteColor
        mealsDropdown.anchorView = self.mealPreferenceTF
        mealsDropdown.bottomOffset = CGPoint(x: 0, y: mealPreferenceTF.frame.size.height + 20)
        mealsDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.mealPreferenceTF.text = item
            self?.delegate?.didTapOnMealPreferenceBtn(cell: self!)
        }
        
    }
  
    
    func setupDropdownforSpecialAssicintence() {
        var specialAssicintenceNameArray = [String]()
        specialAssistancelist1.forEach { i in
            specialAssicintenceNameArray.append(i.description ?? "")
        }
        specialAssistenceDropDown.dataSource = specialAssicintenceNameArray
        specialAssistenceDropDown.direction = .any
        specialAssistenceDropDown.backgroundColor = .WhiteColor
        specialAssistenceDropDown.anchorView = self.specialAssicintenceTF
        specialAssistenceDropDown.bottomOffset = CGPoint(x: 0, y: specialAssicintenceTF.frame.size.height + 20)
        specialAssistenceDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.specialAssicintenceTF.text = item
            self?.delegate?.didTapOnSpecialAssicintenceBtn(cell: self!)
        }
        
    }
    
    
    func showdobDatePicker(){
        // Formate Date
        dobDatePicker.datePickerMode = .date
        dobDatePicker.maximumDate = Date()
        dobDatePicker.preferredDatePickerStyle = .wheels
        
        // Set date restrictions based on age category
        let calendar = Calendar.current
        var components = DateComponents()
        
        switch ageCategory {
        case .adult:
            components.year = -100
            dobDatePicker.minimumDate = calendar.date(byAdding: components, to: Date())
        case .child:
            components.year = -12
            //components.year = -1
            dobDatePicker.minimumDate = calendar.date(byAdding: components, to: Date())
          //  dobDatePicker.maximumDate = calendar.date(byAdding: components, to: Date())
        case .infant:
            components.year = -2
            dobDatePicker.minimumDate = calendar.date(byAdding: components, to: Date())
        }
        
        // ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        dobTF.inputAccessoryView = toolbar
        dobTF.inputView = dobDatePicker
        
    }
    
    func showexpirDatePicker(){
        //Formate Date
        passportDatePicker.datePickerMode = .date
        passportDatePicker.minimumDate = Date()
        passportDatePicker.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        passportExpireDateTF.inputAccessoryView = toolbar
        passportExpireDateTF.inputView = passportDatePicker
        
    }
    
    
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        if dobTF.isFirstResponder {
            dobTF.text = formatter.string(from: dobDatePicker.date)
        } else if passportExpireDateTF.isFirstResponder {
            passportExpireDateTF.text = formatter.string(from: passportDatePicker.date)
        }
        
        delegate?.donedatePicker(cell: self)
    }
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell: self)
    }
    
    
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == nationalityTF {
            // textField.resignFirstResponder()
            dropDown.show()
        }else if textField == titleTF {
            titledropDown.show()
        }else if textField == passportIssuingCountryTF {
            // textField.resignFirstResponder()
            dropDown1.show()
        }
    }
    
    @objc func editingMDCOutlinedTextField(textField:MDCOutlinedTextField) {
        delegate?.editingMDCOutlinedTextField(tf: textField)
    }
    
    
    func setupMale() {
        self.mrRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#254179"))
        self.mrsRadioImg.image = UIImage(named: "radioUnselected")
        self.missRadioImg.image = UIImage(named: "radioUnselected")
    }
    
    func setupFeMale() {
        self.mrRadioImg.image = UIImage(named: "radioUnselected")
        self.mrsRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#254179"))
        self.missRadioImg.image = UIImage(named: "radioUnselected")
    }
    
    func setupOthersGender() {
        self.mrRadioImg.image = UIImage(named: "radioUnselected")
        self.mrsRadioImg.image = UIImage(named: "radioUnselected")
        self.missRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#254179"))
    }
    
    
    @IBAction func didTapOnMrBtnAction(_ sender: Any) {
        delegate?.didTapOnMrBtnAction(cell: self)
    }
    
    @IBAction func didTapOnMrsBtnAction(_ sender: Any) {
        delegate?.didTapOnMrsBtnAction(cell: self)
    }
    
    @IBAction func didTapOnMissBtnAction(_ sender: Any) {
        delegate?.didTapOnMissBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnSaveTravellerDetailsBtnAction(_ sender: Any) {
        delegate?.didTapOnSaveTravellerDetailsBtnAction(cell: self)
    }
    
    
}



extension SaveTravellerDetailsTVCell {
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= maxLength
    }
}
