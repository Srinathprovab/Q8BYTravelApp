//
//  PreBookingViewModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 19/04/23.
//

import Foundation


protocol PreBookingViewModelDelegate : BaseViewModelProtocol {
    func preBookingDetails(response : PreBookingModel)
    func flightBookingDetails(response : FlightBookingModel)
    func processPassengerDetails(response : ProcessPassangerDetailModel)
    func preFlightBookingDetails(response : ProcessPassangerDetailModel)
    func flightPrePaymentDetails(response : sendToPaymentModel)
    func sendtoPaymentDetails(response : sendToPaymentModel)
    func secureBookingDetails(response : sendToPaymentModel)
}

class PreBookingViewModel {
    
    var view: PreBookingViewModelDelegate!
    init(_ view: PreBookingViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_MOBILE_PRE_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.preprocessbooking,parameters: parms, resultType: PreBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.preBookingDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CALL_MOBILE_FLIGHT_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.flightbooking,parameters: parms, resultType: FlightBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.flightBookingDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_PROCESS_PASSENGER_DETAIL_API(dictParam: [String: Any],key:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.processpassengerdetail + key,parameters: parms, resultType: ProcessPassangerDetailModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //  self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.processPassengerDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_PRE_FLIGHT_BOOKING_API(dictParam: [String: Any],key:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.prebooking + key,parameters: parms, resultType: ProcessPassangerDetailModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //     self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.preFlightBookingDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
    func CALL_FLIGHT_PRE_CONF_PAYMENT_API(dictParam: [String: Any],key:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.prepaymentconfirmation + key,parameters: parms, resultType: sendToPaymentModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //     self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.flightPrePaymentDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    func CALL_SENDTO_PAYMENT_API(dictParam: [String: Any],key:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.sendtopayment + key,parameters: parms, resultType: sendToPaymentModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //     self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.sendtoPaymentDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_SECURE_BOOKING_API(dictParam: [String: Any],key:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.securebooking + key,parameters: parms, resultType: sendToPaymentModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.secureBookingDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
}
