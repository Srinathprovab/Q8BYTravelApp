//
//  FlightPrePaymentConfModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 20/04/23.
//

import Foundation


struct FlightPrePaymentConfModel : Codable {
    
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
