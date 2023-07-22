//
//  ConfirmTicketViewmodel.swift
//  QBBYTravelApp
//
//  Created by FCI on 03/07/23.
//

import Foundation



protocol ConfirmTicketViewmodelDelegate : BaseViewModelProtocol {
    func cfdetails(response : ConformTicketModel)
}

class ConfirmTicketViewmodel {
    
    var view: ConfirmTicketViewmodelDelegate!
    init(_ view: ConfirmTicketViewmodelDelegate) {
        self.view = view
    }
    
    
    func CALL_HOME_PAGE_DETAILS_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url,parameters: parms, resultType: ConformTicketModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.cfdetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}



