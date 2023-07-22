//
//  FDViewModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 08/04/23.
//

import Foundation



protocol FDViewModelDelegate : BaseViewModelProtocol {
    func flightDetails(response : FDModel)
}

class FDViewModel {
    
    var view: FDViewModelDelegate!
    init(_ view: FDViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_FLIGHT_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.getFlightDetails,parameters: parms, resultType: FDModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.flightDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
