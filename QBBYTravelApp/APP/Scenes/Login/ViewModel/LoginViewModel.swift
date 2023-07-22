//
//  LoginViewModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 05/04/23.
//

import Foundation


protocol LoginViewModelDelegate : BaseViewModelProtocol {
    func loginSucess(response : LoginModel)
}

class LoginViewModel {
    
    var view: LoginViewModelDelegate!
    init(_ view: LoginViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_LOGIN_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "auth/\(ApiEndpoints.mobilelogin)", parameters: parms, resultType: LoginModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.loginSucess(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
