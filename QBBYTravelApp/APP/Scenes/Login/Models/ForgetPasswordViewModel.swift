//
//  ForgetPasswordViewModel.swift
//  KuwaitWays
//
//  Created by FCI on 24/04/23.
//

import Foundation



protocol ForgetPasswordViewModelDelegate : BaseViewModelProtocol {
    func forgetPasswordDetails(response : LoginModel)
}

class ForgetPasswordViewModel {
    
    var view: ForgetPasswordViewModelDelegate!
    init(_ view: ForgetPasswordViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_FORGET_PASSWORD_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.mobileforgotpassword, parameters: parms, resultType: LoginModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.forgetPasswordDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
