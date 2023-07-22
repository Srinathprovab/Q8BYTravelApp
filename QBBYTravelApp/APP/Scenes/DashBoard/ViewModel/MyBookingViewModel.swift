//
//  MyBookingViewModel.swift
//  KuwaitWays
//
//  Created by FCI on 08/05/23.
//

import Foundation



protocol MyBookingViewModelDelegate : BaseViewModelProtocol {
    func upcommingbookingsdetails(response:MyBookingModel)
    func completedbookingsdetails(response:MyBookingModel)
    func cancelledbookingsdetails(response:MyBookingModel)
}

class MyBookingViewModel {
    
    var view: MyBookingViewModelDelegate!
    init(_ view: MyBookingViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK:  CALL_UPCOMMING_BOOKINGS_API
    func CALL_UPCOMMING_BOOKINGS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.upcomingbookingmobile , urlParams: (parms as! Dictionary<String, String>),parameters: parms, resultType: MyBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.upcommingbookingsdetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    //MARK:  CALL_COMPLETED_BOOKINGS_API
    func CALL_COMPLETED_BOOKINGS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.completedbookingmobile , urlParams: (parms as! Dictionary<String, String>),parameters: parms, resultType: MyBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.completedbookingsdetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    //MARK:  CALL_CANCELLED_BOOKINGS_API
    func CALL_CANCELLED_BOOKINGS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.cancelledbookingmobile , urlParams: (parms as! Dictionary<String, String>),parameters: parms, resultType: MyBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.cancelledbookingsdetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }

}
