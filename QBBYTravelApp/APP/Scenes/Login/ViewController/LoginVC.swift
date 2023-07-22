//
//  LoginVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit

class LoginVC: BaseTableVC {
    
    var tablerow = [TableRow]()
    static var newInstance: LoginVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? LoginVC
        return vc
    }
    var email = String()
    var pass = String()
    var showPwdBool = true
    var payload = [String:Any]()
    var vm:LoginViewModel?
    
    
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
        vm = LoginViewModel(self)
    }
    
    func setupTV() {
        
        commonTableView.registerTVCells(["EmptyTVCell","LogoImgTVCell","LabelTVCell","TextfieldTVCell","RadioButtonTVCell","ButtonTVCell","UnderLineTVCell","SignUpWithTVCell","LabelWithButtonTVCell"])
        
        appendLoginTvcells()
    }
    
    
    func appendLoginTvcells() {
        tablerow.removeAll()
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.LogoImgTVCell))
        tablerow.append(TableRow(title:"Email Address*",text:"1", tempText: "Email Adress",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Password*",key:"pass", text:"2", tempText: "Password",cellType:.TextfieldTVCell))
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Login",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.UnderLineTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.SignUpWithTVCell))
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Not register yet?",subTitle: "",key: "acccreate", tempText: "Create Account",cellType:.LabelWithButtonTVCell))

        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    override func editingTextField(tf: UITextField) {
        
        print(tf.text ?? "")
        switch tf.tag {
        case 1:
            email = tf.text ?? ""
            break
            
        case 2:
            pass = tf.text ?? ""
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
        }else if pass.isEmpty == true {
            showToast(message: "Enter Password")
        }
//        else  if pass.isValidPassword() == false {
//            showToast(message: "Enter Valid Password")
//        }
        
        else {
           
            payload.removeAll()
            payload["username"] = email
            payload["password"] = pass
            vm?.CALL_LOGIN_API(dictParam: payload)
            
        }
    }
    
    override func didTapOnShowPasswordBtn(cell:TextfieldTVCell){
        
        if showPwdBool == true {
          // cell.showImage.image = UIImage(named: "showpass")
            cell.txtField.isSecureTextEntry = false
            showPwdBool = false
        }else {
            cell.txtField.isSecureTextEntry = true
           // cell.showImage.image = UIImage(named: "hidepass")
            showPwdBool = true
        }
        
    }
    
    
    override func didTapOnForGetPassword(cell:TextfieldTVCell){
        guard let vc = ResetPasswordVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    override func didTapOnGoogleBtn(cell: SignUpWithTVCell){
        print("didTapOnGoogleBtn")
    }
    
    
    override func didTapOnBackToCreateAccountBtn(cell: LabelWithButtonTVCell) {
        guard let vc = CreateAccountVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
   
    
    
    @IBAction func didTapOnSkipBtn(_ sender: Any) {
        dismiss(animated: false)
    }
    
}


extension LoginVC:LoginViewModelDelegate {
    
    func loginSucess(response: LoginModel) {
        if response.status == false {
            showToast(message: response.data ?? "Errorrrrr")
            defaults.set(false, forKey: UserDefaultsKeys.userLoggedIn)
            defaults.set("0", forKey: UserDefaultsKeys.userid)
        }else {
            showToast(message: response.data ?? "")
            defaults.set(true, forKey: UserDefaultsKeys.userLoggedIn)
            defaults.set(response.user_id, forKey: UserDefaultsKeys.userid)
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                // Put your code which should be executed with a delay here
                NotificationCenter.default.post(name: NSNotification.Name("logindon"), object: nil)
                dismiss(animated: true)
            }
        }
    }
    
    
}
