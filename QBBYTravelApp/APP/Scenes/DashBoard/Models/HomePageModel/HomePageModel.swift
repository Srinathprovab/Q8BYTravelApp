//
//  HomePageModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 18/04/23.
//

import Foundation

struct HomePageModel : Codable {
    
    let img_url : String?
    let currency : String?
    let flight_top_destinations1 : [Flight_top_destinations1]?
    let perfect_holidays : [Perfect_holidays]?
    
    enum CodingKeys: String, CodingKey {
        
        case img_url = "img_url"
        case currency = "currency"
        case flight_top_destinations1 = "flight_top_destinations1"
        case perfect_holidays = "perfect_holidays"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        img_url = try values.decodeIfPresent(String.self, forKey: .img_url)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        flight_top_destinations1 = try values.decodeIfPresent([Flight_top_destinations1].self, forKey: .flight_top_destinations1)
        perfect_holidays = try values.decodeIfPresent([Perfect_holidays].self, forKey: .perfect_holidays)
    }
    
}
