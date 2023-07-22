//
//  LogoutViewmodel.swift
//  QBBYTravelApp
//
//  Created by FCI on 05/04/23.
//

import Foundation


protocol LogoutViewmodelDelegate : BaseViewModelProtocol {
    func logoutSucess(response : LoginModel)
}

class LogoutViewmodel {
    
    var view: LogoutViewmodelDelegate!
    init(_ view: LogoutViewmodelDelegate) {
        self.view = view
    }
    
    
    func CALL_LOgout_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "auth/\(ApiEndpoints.mobilelogout)", parameters: parms, resultType: LoginModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.logoutSucess(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
