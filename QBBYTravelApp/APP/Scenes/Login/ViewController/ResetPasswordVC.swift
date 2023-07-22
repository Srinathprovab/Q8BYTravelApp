//
//  ResetPasswordVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit

class ResetPasswordVC: BaseTableVC {
    
    
    var tablerow = [TableRow]()
    static var newInstance: ResetPasswordVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ResetPasswordVC
        return vc
    }
    var email = String()
    var mobileNo = String()
    var payload = [String:Any]()
    var vm:mobileforgotpasswordViewModel?
    
    
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
        vm = mobileforgotpasswordViewModel(self)
        setupTV()
    }
    
    func setupTV() {
        commonTableView.registerTVCells(["EmptyTVCell","LogoImgTVCell","LabelTVCell","TextfieldTVCell","RadioButtonTVCell","ButtonTVCell"])
        appendLoginTvcells()
    }
    
    
    
    func appendLoginTvcells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:60,cellType:.EmptyTVCell))
        tablerow.append(TableRow(key:"resetpassword",cellType:.LogoImgTVCell))
        tablerow.append(TableRow(title:"Email Address*",text:"1", tempText: "Email Adress",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Mobile No*",text:"22", tempText: "Mobile No",cellType:.TextfieldTVCell))
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Send",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    override func editingTextField(tf: UITextField) {
        
        
        switch tf.tag {
        case 1:
            email = tf.text ?? ""
            break
            
        case 22:
            print(tf.text ?? "")
            mobileNo = tf.text ?? ""
            break
            
        default:
            break
        }
    }
    
    
    override func btnAction(cell: ButtonTVCell){
        
        if email.isEmpty == true {
            showToast(message: "Enter Email Address")
        }else  if email.isValidEmail() == false {
            showToast(message: "Enter Valid Address")
        }else if mobileNo.isEmpty == true {
            showToast(message: "Enter Mobile No")
        }else{
            print("Callllll apiiiiiii")
            payload["email"] = email
            payload["phone"] = mobileNo
            vm?.CALL_MOBILE_FORGET_PASSWORD_API(dictParam: payload)
        }
    }
    
    
    @IBAction func didTapOnSkipBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
}


extension ResetPasswordVC: mobileforgotpasswordViewModelDelegate{
    func forgetPassword(response: LoginModel) {
        showToast(message: response.data ?? "")
    }
    
    
}
