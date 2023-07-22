import Foundation
import Alamofire


protocol SelectCityViewModelProtocal : BaseViewModelProtocol {
    func ShowCityList(response : [SelectCityModel])
    func getHotelCityList(response : [CityOrHotelListModel])
    func getHolidayCityList(response : [HolidayCitySearchModel])
}

class SelectCityViewModel {
    
    var view: SelectCityViewModelProtocal!
    init(_ view: SelectCityViewModelProtocal) {
        self.view = view
    }
    
    
    func CallShowCityListAPI(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.getairportcodelist , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: [SelectCityModel].self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.ShowCityList(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CALL_GET_HOTEL_CITY_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.gethotelcitylist , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: [CityOrHotelListModel].self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.getHotelCityList(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    func CALL_GET_HOLIDAY_CITY_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.getholidaytcitylist , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: [HolidayCitySearchModel].self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.getHolidayCityList(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
