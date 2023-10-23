//
//  CreateAccountTVCell.swift
//  KuwaitWays
//
//  Created by FCI on 23/05/23.
//

import UIKit
import MaterialComponents
import DropDown

protocol CreateAccountTVCellDelegate {
    func didTapOnCountryCodeBtnAction(cell:CreateAccountTVCell)
    func didTapOnCreateAccountBtnBtnAction(cell:CreateAccountTVCell)
    func editingMDCOutlinedTextField(tf:MDCOutlinedTextField)
    func didTapOnBackToLoginBtnAction(cell:CreateAccountTVCell)
    
    func donedatePicker(cell:CreateAccountTVCell)
    func cancelDatePicker(cell:CreateAccountTVCell)
}

class CreateAccountTVCell: TableViewCell {
    
    @IBOutlet weak var createAccountBtnView: UIView!
    @IBOutlet weak var fnameTF: MDCOutlinedTextField!
    @IBOutlet weak var lnameTF: MDCOutlinedTextField!
    @IBOutlet weak var emailTF: MDCOutlinedTextField!
    @IBOutlet weak var countryCodeTF: MDCOutlinedTextField!
    @IBOutlet weak var mobileTF: MDCOutlinedTextField!
    @IBOutlet weak var createPassTF: MDCOutlinedTextField!
    @IBOutlet weak var confPassTF: MDCOutlinedTextField!
    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var backtoLoginBtn: UIButton!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var passImg: UIImageView!
    @IBOutlet weak var showPass1Img: UIImageView!
    @IBOutlet weak var countrycodeTV: UITableView!
    @IBOutlet weak var countrycodeTVHeight: NSLayoutConstraint!
    @IBOutlet weak var dobTF: MDCOutlinedTextField!
    
    let dobDatePicker = UIDatePicker()
    var mobilenoMaxLength = Int()
    var filterdcountrylist = [Country_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var showbool1 = true
    var showbool2 = true
    var chkBool = true
    let dropDown = DropDown()
    var isSearchBool = Bool()
    var searchText = String()
    var delegate:CreateAccountTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        countrycodeTVHeight.constant = 0
        loadCountryNamesAndCode()
    }
    
    func loadCountryNamesAndCode(){
        countryNames.removeAll()
        countrycodesArray.removeAll()
        countrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.country_code ?? "")
        }
        DispatchQueue.main.async {[self] in
            dropDown.dataSource = countryNames
        }
    }
    
    
    func setupUI() {
        
        setupTextField(txtField: fnameTF, tag1: 1, label: "First Name", placeholder: "Enter First Name")
        setupTextField(txtField: lnameTF, tag1: 2, label: "Last Name", placeholder: "Enter Last Name")
        setupTextField(txtField: emailTF, tag1: 3, label: "Email Address", placeholder: "Enter Email Address")
        setupTextField(txtField: countryCodeTF, tag1: 7, label: "Code", placeholder: "Kuwait")
        setupTextField(txtField: mobileTF, tag1: 4, label: "Mobile Number", placeholder: "Mobile Number")
        setupTextField(txtField: createPassTF, tag1: 5, label: "Create Password", placeholder: "Create Password")
        setupTextField(txtField: confPassTF, tag1: 6, label: "Confirm Password", placeholder: "Confirm Password")
        setupTextField(txtField: dobTF, tag1: 7, label: "Date Of Birth", placeholder: "DOB")

        createPassTF.isSecureTextEntry = true
        confPassTF.isSecureTextEntry = true
        createAccountBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 4)
       // countryCodeTF.text = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode)
        
        countryCodeBtn.setTitle("", for: .normal)
        countryCodeBtn.addTarget(self, action: #selector(didTapOnCountryCodeBtnAction(_:)), for: .touchUpInside)
        createAccountBtn.setTitle("", for: .normal)
        createAccountBtn.addTarget(self, action: #selector(didTapOnCreateAccountBtnBtnAction(_:)), for: .touchUpInside)
        backtoLoginBtn.setTitle("", for: .normal)
        backtoLoginBtn.addTarget(self, action: #selector(didTapOnBackToLoginBtnAction(_:)), for: .touchUpInside)
        
        setupDropDown()
        countryCodeBtn.isHidden = true
        countryCodeTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countryCodeTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        showdobDatePicker()
       
    }
    
    
    func showdobDatePicker(){
        //Formate Date
        dobDatePicker.datePickerMode = .date
        dobDatePicker.maximumDate = Date()
        dobDatePicker.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dobTF.inputAccessoryView = toolbar
        dobTF.inputView = dobDatePicker
        
    }
    
    
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        dobTF.text = formatter.string(from: dobDatePicker.date)
        
        delegate?.donedatePicker(cell: self)
    }
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell: self)
    }
    
    
    
    @objc func didTapOnCountryCodeBtnAction(_ sender:UIButton) {
        dropDown.show()
    }
    
    @objc func didTapOnCreateAccountBtnBtnAction(_ sender:UIButton) {
        delegate?.didTapOnCreateAccountBtnBtnAction(cell: self)
    }
    
    
    @objc func didTapOnBackToLoginBtnAction(_ sender:UIButton) {
        delegate?.didTapOnBackToLoginBtnAction(cell: self)
    }
    
    
    func setupTextField(txtField:MDCOutlinedTextField,tag1:Int,label:String,placeholder:String) {
        txtField.delegate = self
        txtField.tag = tag1
        txtField.label.text = "\(label)*"
        txtField.placeholder = placeholder
        txtField.backgroundColor = .clear
        txtField.font = UIFont.LatoRegular(size: 16)
        txtField.addTarget(self, action: #selector(editingMDCOutlinedTextField(textField:)), for: .editingChanged)
        txtField.label.textColor = .SubTitleColor
        txtField.setOutlineColor( .black, for: .editing)
        txtField.setOutlineColor( .red , for: .disabled)
        txtField.setOutlineColor( .lightGray.withAlphaComponent(0.4) , for: .normal)
        
    }
    
    
    var cname = String()
    func setupDropDown() {
        
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.countryCodeTF
        dropDown.bottomOffset = CGPoint(x: 0, y: countryCodeTF.frame.size.height + 25)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.countryCodeTF.text = self?.countrycodesArray[index] ?? ""
            self?.countryCodeTF.resignFirstResponder()
            self?.cname = self?.countryNames[index] ?? ""
            self?.mobileTF.text = ""
            self?.mobileTF.becomeFirstResponder()
            self?.delegate?.didTapOnCountryCodeBtnAction(cell: self!)
        }
        
    }
    
    @objc func editingMDCOutlinedTextField(textField:MDCOutlinedTextField) {
        
        if textField == mobileTF {
            if let text = textField.text {
                let length = text.count
                if length != mobilenoMaxLength {
                    mobilenoMaxLengthBool = false
                }else{
                    mobilenoMaxLengthBool = true
                }
               
            } else {
                mobilenoMaxLengthBool = false
            }
        }
        
        delegate?.editingMDCOutlinedTextField(tf: textField)
    }
    
    
    
    @IBAction func didTapOnCheckBox(_ sender: Any) {
        if chkBool == true {
            checkImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
            chkBool = false
        }else {
            checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
            chkBool = true
        }
    }
    
    
    
    @IBAction func didTapOnShowPassBtnAction(_ sender: Any) {
       
        if showbool1 == true {
            createPassTF.isSecureTextEntry = false
            showPass1Img.image = UIImage(named: "showpass")
            showbool1 = false
        }else {
            createPassTF.isSecureTextEntry = true
            showPass1Img.image = UIImage(named: "hidepass")
            showbool1 = true
        }
    }
    
    @IBAction func didTapOnShowPassBtnAction1(_ sender: Any) {
        if showbool2 == true {
            confPassTF.isSecureTextEntry = false
            passImg.image = UIImage(named: "showpass")
            showbool2 = false
        }else {
            confPassTF.isSecureTextEntry = true
            passImg.image = UIImage(named: "hidepass")
            showbool2 = true
        }
    }
    
    
    
    @objc func searchTextBegin(textField: MDCOutlinedTextField) {
        textField.text = ""
        loadCountryNamesAndCode()
        dropDown.show()
    }
    
    
    @objc func searchTextChanged(textField: MDCOutlinedTextField) {
        searchText = textField.text ?? ""
        filterContentForSearchText(searchText)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        filterdcountrylist.removeAll()
        filterdcountrylist = countrylist.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        countryNames.removeAll()
        countrycodesArray.removeAll()
        filterdcountrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.country_code ?? "")
        }
        dropDown.dataSource = countryNames
        dropDown.show()
       
    }
    
    
    
}


extension CreateAccountTVCell {
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField.tag == 4 {
            mobilenoMaxLength = cname.getMobileNumberMaxLength() ?? 8
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
        }else {
            mobilenoMaxLength = 50
        }
        
        
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= mobilenoMaxLength
    }
}


