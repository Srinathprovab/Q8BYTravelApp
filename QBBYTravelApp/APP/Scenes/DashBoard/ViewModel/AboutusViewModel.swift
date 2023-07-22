//
//  AboutusViewModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 05/04/23.
//

import Foundation



protocol AboutusViewModelDelegate : BaseViewModelProtocol {
    func aboutusDetails(response : AboutusModel)
}

class AboutusViewModel {
    
    var view: AboutusViewModelDelegate!
    init(_ view: AboutusViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_ABOUTUS_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url, urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: AboutusModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.aboutusDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
