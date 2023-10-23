//
//  AirlinesListVModel.swift
//  KuwaitWays
//
//  Created by FCI on 18/10/23.
//

import Foundation

protocol AirlinesListVModelDelegate : BaseViewModelProtocol {
    func airlineList(response : AirlinesListModel)
}

class AirlinesListVModel {
    
    var view: AirlinesListVModelDelegate!
    init(_ view: AirlinesListVModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_AIRLINE_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        //   self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_getAirlineList, parameters: parms, resultType: AirlinesListModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.airlineList(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
