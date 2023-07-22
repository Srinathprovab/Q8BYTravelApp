//
//  ProfileUpdateViewModel.swift
//  KuwaitWays
//
//  Created by FCI on 05/05/23.
//

import Foundation



protocol ProfileUpdateViewModelDelegate : BaseViewModelProtocol {
    func profileDetails(response : ProfileUpdateModel)
}

class ProfileUpdateViewModel {
    
    var view: ProfileUpdateViewModelDelegate!
    init(_ view: ProfileUpdateViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_SHOW_PROFILE_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.updatemobileprofile, urlParams: parms as? Dictionary<String, String>,parameters: parms, resultType: ProfileUpdateModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.profileDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
