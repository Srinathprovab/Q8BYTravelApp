//
//  MJ_flight_list.swift
//  QBBYTravelApp
//
//  Created by FCI on 12/07/23.
//

import Foundation

struct MJ_flight_list : Codable {
    let totalPrice : String?
    let basePrice : String?
    let taxes : String?
    let totalPrice_API : String?
    let aPICurrencyType : String?
    let fareType : String?
    let flight_details : Flight_details?
    let selectedResult : String?
    let access_key : String?
    
    
    enum CodingKeys: String, CodingKey {
        
        case totalPrice = "TotalPrice"
        case basePrice = "BasePrice"
        case taxes = "Taxes"
        case totalPrice_API = "TotalPrice_API"
        case aPICurrencyType = "APICurrencyType"
        case fareType = "FareType"
        case flight_details = "flight_details"
        case selectedResult = "selectedResult"
        case access_key = "access_key"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalPrice = try values.decodeIfPresent(String.self, forKey: .totalPrice)
        basePrice = try values.decodeIfPresent(String.self, forKey: .basePrice)
        taxes = try values.decodeIfPresent(String.self, forKey: .taxes)
        totalPrice_API = try values.decodeIfPresent(String.self, forKey: .totalPrice_API)
        aPICurrencyType = try values.decodeIfPresent(String.self, forKey: .aPICurrencyType)
        fareType = try values.decodeIfPresent(String.self, forKey: .fareType)
        flight_details = try values.decodeIfPresent(Flight_details.self, forKey: .flight_details)
        selectedResult = try values.decodeIfPresent(String.self, forKey: .selectedResult)
        access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
        
    }
    
}
