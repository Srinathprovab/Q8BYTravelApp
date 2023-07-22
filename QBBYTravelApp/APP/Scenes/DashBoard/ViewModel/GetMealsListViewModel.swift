//
//  GetMealsListViewModel.swift
//  KuwaitWays
//
//  Created by FCI on 24/05/23.
//

import Foundation



protocol GetMealsListViewModelDelegate : BaseViewModelProtocol {
    func mealList(response:GetMealsListModel)
    func specialAssistancelist(response:GetMealsListModel)
}

class GetMealsListViewModel {
    
    var view: GetMealsListViewModelDelegate!
    init(_ view: GetMealsListViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK: -  CALL_GET_MEAL_LIST_API
    func CALL_GET_MEAL_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.getMeals_list , parameters: parms, resultType: GetMealsListModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.mealList(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    //MARK: -  CALL_GET_special_Assistance_list_API
    func CALL_GET_special_Assistance_list_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.getSpecialAssistancelist , parameters: parms, resultType: GetMealsListModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.specialAssistancelist(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
}
