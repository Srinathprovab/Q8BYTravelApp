//
//  HolidaySearchResultViewModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 24/05/23.
//

import Foundation



protocol HolidaySearchResultViewModelDelegate : BaseViewModelProtocol {
    func holidaySearchList(response:HolidaySearchResultModel)
}

class HolidaySearchResultViewModel {
    
    var view: HolidaySearchResultViewModelDelegate!
    init(_ view: HolidaySearchResultViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK: - CALL_HOLIDAY_SEARCH_LIST_API
    func CALL_HOLIDAY_SEARCH_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.preholidaysearch,urlParams: parms as? Dictionary<String, String>,parameters: parms, resultType: HolidaySearchResultModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.holidaySearchList(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
}
