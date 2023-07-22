//
//  FDModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 08/04/23.
//

import Foundation


struct FDModel : Codable {
    let priceDetails : PriceDetails?
    let farerulesref_content : String?
    let fareRulehtml : [FareRulehtml]?
    let journeySummary : [JourneySummary]?
    let flightDetails : [[FlightDetails]]?
    let status : Bool?
    let fare_rule_ref_key : String?
    
    enum CodingKeys: String, CodingKey {
        
        case priceDetails = "priceDetails"
        case farerulesref_content = "farerulesref_content"
        case fareRulehtml = "fareRulehtml"
        case journeySummary = "journeySummary"
        case flightDetails = "flightDetails"
        case status = "status"
        case fare_rule_ref_key = "fare_rule_ref_key"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        priceDetails = try values.decodeIfPresent(PriceDetails.self, forKey: .priceDetails)
        farerulesref_content = try values.decodeIfPresent(String.self, forKey: .farerulesref_content)
        fareRulehtml = try values.decodeIfPresent([FareRulehtml].self, forKey: .fareRulehtml)
        journeySummary = try values.decodeIfPresent([JourneySummary].self, forKey: .journeySummary)
        flightDetails = try values.decodeIfPresent([[FlightDetails]].self, forKey: .flightDetails)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        fare_rule_ref_key = try values.decodeIfPresent(String.self, forKey: .fare_rule_ref_key)
    }
    
}


