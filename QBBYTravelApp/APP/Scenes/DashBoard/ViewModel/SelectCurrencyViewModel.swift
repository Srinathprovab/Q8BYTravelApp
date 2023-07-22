//
//  SelectCurrencyViewModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 05/04/23.
//

import Foundation




protocol SelectCurrencyViewModelDelgate : BaseViewModelProtocol {
    func currencyList(response : SelectCurrencyModel)
}

class SelectCurrencyViewModel {
    
    var view: SelectCurrencyViewModelDelgate!
    init(_ view: SelectCurrencyViewModelDelgate) {
        self.view = view
    }
    
    
    func CALL_GET_CURRENCY_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.getCurrencyList, parameters: parms, resultType: SelectCurrencyModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.currencyList(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
