//
//  CreateAccountVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit

class CreateAccountVC: BaseTableVC {
    
    
    var tablerow = [TableRow]()
    static var newInstance: CreateAccountVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CreateAccountVC
        return vc
    }
    var fname = String()
    var lname = String()
    var email = String()
    var mobile = String()
    var pass = String()
    var cpass = String()
    
    
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
        setupTV()
    }
    
    func setupTV() {
        
        commonTableView.registerTVCells(["EmptyTVCell","LogoImgTVCell","LabelTVCell","TextfieldTVCell","RadioButtonTVCell","ButtonTVCell","LabelWithButtonTVCell"])
        
        appendLoginTvcells()
    }
    
    
    func appendLoginTvcells() {
        tablerow.removeAll()
        
      //  tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(key:"createaccount",cellType:.LogoImgTVCell))
       // tablerow.append(TableRow(title:"Create Account",subTitle: "please fill the below details",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Frist Name *",text:"1", tempText: "Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Last Name*",text:"2", tempText: "Last Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Email Address*",text:"3", tempText: "Email Adress",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Mobile Number*",key: "mobile",text:"4", moreData:["+91","+988","+133"], tempText: "Mobile",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Create Password*",key:"pwd", text:"5", tempText: "Password",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Confirm Password*",key:"pwd",text:"6", tempText: "Password",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Yes ! i want to receive the latest travel deals, offers promotions",cellType:.RadioButtonTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Create Account",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        tablerow.append(TableRow(title:"Back To !",subTitle: "",key: "backlogin", tempText: "Login",cellType:.LabelWithButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    override func editingTextField(tf: UITextField) {
        
        print(tf.text ?? "")
        switch tf.tag {
        case 1:
            fname = tf.text ?? ""
            break
            
        case 2:
            lname = tf.text ?? ""
            break
            
        case 3:
            email = tf.text ?? ""
            break
            
        case 4:
            mobile = tf.text ?? ""
            break
            
        case 5:
            pass = tf.text ?? ""
            break
            
        case 6:
            cpass = tf.text ?? ""
            break
        default:
            break
        }
    }
    
    
    override func btnAction(cell: ButtonTVCell){
        
        if fname.isEmpty == true {
            showToast(message: "Enter First Name")
        }else  if lname.isEmpty == true {
            showToast(message: "Enter Last Name")
        }else  if email.isEmpty == true {
            showToast(message: "Enter Email Address")
        }else  if email.isValidEmail() == false {
            showToast(message: "Enter Valid Address")
        }else if mobile.isEmpty == true {
            showToast(message: "Enter Mobile Number")
        }else  if pass.isEmpty == true {
            showToast(message: "Enter Password")
        }else  if pass.isValidPassword() == false {
            showToast(message: "Enter Valid Password")
        }else  if cpass.isEmpty == true {
            showToast(message: "Enter Conform Password")
        }else  if pass != cpass {
            showToast(message: "Password Should Match")
        }else {
            showToast(message: "Call apiiiiiiii.........")
        }
    }
    
    
    override func didTapOnCountryCodeDropDownBtn(cell:TextfieldTVCell){
        cell.dropDown.show()
    }
    
    
    @IBAction func didTapOnSkipBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    var bool = true
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: IndexPath(item: 10, section: 0)) as? RadioButtonTVCell {
//            if bool == true {
//                cell.radioImg.image = UIImage(named: "check")
//                bool = false
//            }else {
//                cell.radioImg.image = UIImage(named: "uncheck")
//                bool = true
//            }
//        }
//    }
    
    override func didTapOnBackToLoginBtn(cell: LabelWithButtonTVCell) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}
