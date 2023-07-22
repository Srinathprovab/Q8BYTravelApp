//
//  CountryListViewModel.swift
//  KuwaitWays
//
//  Created by FCI on 25/04/23.
//

import Foundation


//protocol CountryListViewModelDelegate : BaseViewModelProtocol {
//    func countryList(response : CountryListModel)
//}
//
//class CountryListViewModel {
//    
//    var view: CountryListViewModelDelegate!
//    init(_ view: CountryListViewModelDelegate) {
//        self.view = view
//    }
//    
//    
//    func CALL_GET_COUNTRY_LIST_API(dictParam: [String: Any]){
//        let parms = NSDictionary(dictionary:dictParam)
//        print("Parameters = \(parms)")
//        
//        self.view?.showLoader()
//        
//        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.countrylist1, parameters: parms, resultType: CountryListModel.self, p:dictParam) { sucess, result, errorMessage in
//            
//            DispatchQueue.main.async {
//                self.view?.hideLoader()
//                if sucess {
//                    guard let response = result else {return}
//                    self.view.countryList(response: response)
//                } else {
//                    self.view.showToast(message: errorMessage ?? "")
//                }
//            }
//        }
//    }
//    
//    
//    
//    
//}
