//
//  HolidaySearchResultModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 24/05/23.
//

import Foundation


struct HolidaySearchResultModel : Codable {
    
    let searchResult : [SearchResult]?
    let theme_name : String?
    let region_set : String?
    let country_set : String?
    let category_set : String?
    let search_id : Int?
    let currency_obj : Currency_obj?
    let status : Bool?
    let data : String?
    
    enum CodingKeys: String, CodingKey {
        
        case searchResult = "searchResult"
        case theme_name = "theme_name"
        case region_set = "region_set"
        case country_set = "country_set"
        case category_set = "category_set"
        case search_id = "search_id"
        case currency_obj = "currency_obj"
        case status = "status"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        searchResult = try values.decodeIfPresent([SearchResult].self, forKey: .searchResult)
        theme_name = try values.decodeIfPresent(String.self, forKey: .theme_name)
        region_set = try values.decodeIfPresent(String.self, forKey: .region_set)
        country_set = try values.decodeIfPresent(String.self, forKey: .country_set)
        category_set = try values.decodeIfPresent(String.self, forKey: .category_set)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        currency_obj = try values.decodeIfPresent(Currency_obj.self, forKey: .currency_obj)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(String.self, forKey: .data)
    }
    
}
