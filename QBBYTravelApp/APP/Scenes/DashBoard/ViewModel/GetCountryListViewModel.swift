//
//  GetCountryListViewModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 19/04/23.
//

import Foundation


protocol GetCountryListViewModelDelegate : BaseViewModelProtocol {
    func countryList(response : GetCountryListModel)
}

class GetCountryListViewModel {
    
    var view: GetCountryListViewModelDelegate!
    init(_ view: GetCountryListViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_COUNTRY_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
       // self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.getCountrylist,parameters: parms, resultType: GetCountryListModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
               // self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.countryList(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
