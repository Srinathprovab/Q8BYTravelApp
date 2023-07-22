//
//  HotelDetailsViewModel.swift
//  KuwaitWays
//
//  Created by FCI on 03/05/23.
//

import Foundation


protocol HotelDetailsViewModelDelegate : BaseViewModelProtocol {
    func hotelDetails(response:HotelDetailsModel)
}

class HotelDetailsViewModel {
    
    var view: HotelDetailsViewModelDelegate!
    init(_ view: HotelDetailsViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK:  Get voucher Details API
    func CALL_GET_HOTEL_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.hoteldetails,urlParams: parms as? Dictionary<String, String>,parameters: parms ,resultType: HotelDetailsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
}
