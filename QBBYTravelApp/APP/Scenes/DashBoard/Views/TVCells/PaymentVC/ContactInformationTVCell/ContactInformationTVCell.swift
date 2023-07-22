//
//  ContactInformationTVCell.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit
import DropDown

protocol ContactInformationTVCellDelegate {
    func didTapOnCountryCodeBtn(cell:ContactInformationTVCell)
    func editingTextField(tf:UITextField)
    func didTapOnDropDownBtn(cell:ContactInformationTVCell)
}

class ContactInformationTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var emailTfView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileNoView: UIView!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var countryCodeLbl: UILabel!
    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var countrycodeTF: UITextField!
    
    
    var maxLength = 8
    var isSearchBool = Bool()
    var searchText = String()
    var filterdcountrylist = [Country_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    
    var nationalityCode = String()
    let dropDown = DropDown()
    var countryNameArray = [String]()
    var billingCountryCode = String()
    var billingCountryName = String()
    var delegate:ContactInformationTVCellDelegate?
    
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
        filterdcountrylist = countrylist
        loadCountryNamesAndCode()
    }
    
    
    func loadCountryNamesAndCode(){
        countryNames.removeAll()
        countrycodesArray.removeAll()
        isocountrycodeArray.removeAll()
        originArray.removeAll()
        
        filterdcountrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.country_code ?? "")
            isocountrycodeArray.append(i.iso_country_code ?? "")
            originArray.append(i.origin ?? "")
            print(i.name ?? "")
        }
        
        DispatchQueue.main.async {[self] in
            dropDown.dataSource = countryNames
        }
    }
    
    
    func setupUI() {
       
        
      //  setupViews(v: holderView, radius: 4, color: .WhiteColor)
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        holderView.layer.cornerRadius = 4
        holderView.clipsToBounds = true
        
        setupViews(v: emailTfView, radius: 4, color: .WhiteColor)
        setupViews(v: mobileNoView, radius: 4, color: .WhiteColor)
        setupViews(v: codeView, radius: 0, color: .WhiteColor)
        
        
        setupLabels(lbl: titlelbl, text: "Contact Information", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16))
        setupLabels(lbl: subTitlelbl, text: "E-Ticket will be sent to the registered email address", textcolor: .SubTitleColor, font: .LatoRegular(size: 12))
        //    setupLabels(lbl: countryCodeLbl, text: "+965", textcolor: .SubTitleColor, font: .LatoRegular(size: 16))
        
        countryCodeLbl.isHidden = true
        
        emailTfView.layer.borderWidth = 1
        mobileNoView.layer.borderWidth = 1
        countryCodeBtn.setTitle("", for: .normal)
        
        
        mobileTF.backgroundColor = .clear
        mobileTF.setLeftPaddingPoints(20)
        mobileTF.font = UIFont.LatoRegular(size: 16)
        mobileTF.tag = 222
        mobileTF.delegate = self
        mobileTF.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        
        setuptf(tf: emailTF, tag1: 111, leftpadding: 20, font: .LatoRegular(size: 16), placeholder: "Email Address")
        setuptf(tf: mobileTF, tag1: 222, leftpadding: 20, font: .LatoRegular(size: 16), placeholder: "Enter Mobile Number")
        setuptf(tf: countrycodeTF, tag1: 333, leftpadding: 20, font: .LatoRegular(size: 16), placeholder: "Kuwait")
      //  countrycodeTF.text = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode)
        
        setupDropDown()
        countryCodeBtn.isHidden = true
        countrycodeTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countrycodeTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
    }
    
    
    func setuptf(tf:UITextField,tag1:Int,leftpadding:Int,font:UIFont,placeholder:String){
        tf.backgroundColor = .clear
        tf.placeholder = placeholder
        tf.setLeftPaddingPoints(CGFloat(leftpadding))
        tf.font = font
        tf.tag = tag1
        tf.delegate = self
        tf.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    @objc func editingText(textField:UITextField) {
        delegate?.editingTextField(tf: textField)
    }
    
    @IBAction func didTapOnCountryCodeBtn(_ sender: Any) {
        dropDown.show()
        //  delegate?.didTapOnCountryCodeBtn(cell: self)
    }
    
    func setupDropDown() {
        
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.countryCodeBtn
        dropDown.bottomOffset = CGPoint(x: 0, y: countryCodeBtn.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.countryCodeLbl.text = self?.countrycodesArray[index]
            self?.billingCountryCode = self?.isocountrycodeArray[index] ?? ""
            self?.billingCountryName = self?.countryNames[index] ?? ""
            self?.nationalityCode = self?.originArray[index] ?? ""
            self?.countryCodeLbl.textColor = .AppLabelColor
            
            
            
            self?.countrycodeTF.text = self?.countrycodesArray[index] ?? ""
            self?.countrycodeTF.resignFirstResponder()
            self?.mobileTF.text = ""
            self?.mobileTF.becomeFirstResponder()
            
            self?.delegate?.didTapOnDropDownBtn(cell: self!)
            
        }
    }
    
    
    
    
    @objc func searchTextBegin(textField: UITextField) {
        textField.text = ""
        filterdcountrylist.removeAll()
        filterdcountrylist = countrylist
        loadCountryNamesAndCode()
        dropDown.show()
    }
    
    
    @objc func searchTextChanged(textField: UITextField) {
        searchText = textField.text ?? ""
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
        }
        
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        filterdcountrylist.removeAll()
        filterdcountrylist = countrylist.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        loadCountryNamesAndCode()
        dropDown.show()
        
    }
    
    
}


extension ContactInformationTVCell {
    
    //MARK - UITextField Delegates
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == mobileTF {
            
            maxLength = self.billingCountryName.getMobileNumberMaxLength() ?? 8
            
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && newString.length <= maxLength
            
        }else {
            maxLength = 25
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        //  return true
    }
    
    
}

