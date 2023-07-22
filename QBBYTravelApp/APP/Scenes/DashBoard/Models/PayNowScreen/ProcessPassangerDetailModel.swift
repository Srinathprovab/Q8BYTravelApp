//
//  ProcessPassangerDetailModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 20/04/23.
//

import Foundation

struct ProcessPassangerDetailModel : Codable {
    let form_url : String?
    let status : Bool?
    let form_params : pForm_params?
    
    enum CodingKeys: String, CodingKey {
        
        case form_url = "form_url"
        case status = "status"
        case form_params = "form_params"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        form_url = try values.decodeIfPresent(String.self, forKey: .form_url)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        form_params = try values.decodeIfPresent(pForm_params.self, forKey: .form_params)
    }
    
}


struct pForm_params : Codable {
    let app_reference : String?
    let promocode_val : String?
    
    enum CodingKeys: String, CodingKey {
        
        case app_reference = "app_reference"
        case promocode_val = "promocode_val"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        promocode_val = try values.decodeIfPresent(String.self, forKey: .promocode_val)
    }
    
}





struct sendToPaymentModel : Codable {
    let form_url : String?
    let msg : String?
    let status : Bool?

    enum CodingKeys: String, CodingKey {

        case form_url = "form_url"
        case msg = "msg"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        form_url = try values.decodeIfPresent(String.self, forKey: .form_url)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }

}
