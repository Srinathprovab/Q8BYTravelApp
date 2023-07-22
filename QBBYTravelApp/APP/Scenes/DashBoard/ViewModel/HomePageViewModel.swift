//
//  HomePageViewModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 18/04/23.
//

import Foundation





protocol HomePageViewModelDelegate : BaseViewModelProtocol {
    func homepageDetails(response : HomePageModel)
}

class HomePageViewModel {
    
    var view: HomePageViewModelDelegate!
    init(_ view: HomePageViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_HOME_PAGE_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.gethomePage,parameters: parms, resultType: HomePageModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.homepageDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
