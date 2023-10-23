//
//  RegisterUserViewModel.swift
//  KuwaitWays
//
//  Created by FCI on 24/04/23.
//

import Foundation


protocol RegisterUserViewModelDelegate : BaseViewModelProtocol {
    func registerUserSucess(response : RegisterUserModel)
}

class RegisterUserViewModel {
    
    var view: RegisterUserViewModelDelegate!
    init(_ view: RegisterUserViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_REGISTER_USER_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.mobileregister, parameters: parms, resultType: RegisterUserModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.registerUserSucess(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
