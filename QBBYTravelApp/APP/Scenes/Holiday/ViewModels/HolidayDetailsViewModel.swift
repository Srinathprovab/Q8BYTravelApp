//
//  HolidayDetailsViewModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 24/05/23.
//

import Foundation


protocol HolidayDetailsViewModelDelegate : BaseViewModelProtocol {
    func holidayDetails(response:HolidayDetailsModel)
}

class HolidayDetailsViewModel {
    
    var view: HolidayDetailsViewModelDelegate!
    init(_ view: HolidayDetailsViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK: - CALL_HOLIDAY_DETAILS_API
    func CALL_HOLIDAY_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.toursdetails,urlParams: parms as? Dictionary<String, String>,parameters: parms, resultType: HolidayDetailsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.holidayDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
}
