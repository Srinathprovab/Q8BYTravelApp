//
//  mobileforgotpasswordViewModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 05/04/23.
//

import Foundation


protocol mobileforgotpasswordViewModelDelegate : BaseViewModelProtocol {
    func forgetPassword(response : LoginModel)
}

class mobileforgotpasswordViewModel {
    
    var view: mobileforgotpasswordViewModelDelegate!
    init(_ view: mobileforgotpasswordViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_MOBILE_FORGET_PASSWORD_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "auth/\(ApiEndpoints.mobileforgotpassword)", parameters: parms, resultType: LoginModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.forgetPassword(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
