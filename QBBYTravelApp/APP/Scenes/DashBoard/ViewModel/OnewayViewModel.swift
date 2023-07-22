//
//  OnewayViewModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 07/04/23.
//

import Foundation



protocol OnewayViewModelDelegate : BaseViewModelProtocol {
    func onewayFlightList(response : OnewayModel)
    func multicityFlightList(response : MulticityModel)
}

class OnewayViewModel {
    
    var view: OnewayViewModelDelegate!
    init(_ view: OnewayViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_FLIGHT_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.mobilepreflightsearch,urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: OnewayModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.onewayFlightList(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_GET_MULTICITY_FLIGHT_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.mobilepreflightsearch,urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: MulticityModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.multicityFlightList(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
