//
//  HotelListViewModel.swift
//  KuwaitWays
//
//  Created by FCI on 02/05/23.
//

import Foundation



protocol HotelListViewModelDelegate : BaseViewModelProtocol {
    func hotelList(response:HotelListModel)
}

class HotelListViewModel {
    
    var view: HotelListViewModelDelegate!
    init(_ view: HotelListViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK:  Get voucher Details API
    func CALL_GET_HOTEL_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.mobileprehotelsearch,urlParams: parms as? Dictionary<String, String>,parameters: parms, resultType: HotelListModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelList(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
}
