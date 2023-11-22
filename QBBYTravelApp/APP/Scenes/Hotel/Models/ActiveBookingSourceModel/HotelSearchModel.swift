//
//  HotelSearchModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 22/11/23.
//

import Foundation


struct HotelSearchModel : Codable {
    let status : Bool?
    let msg : String?
    let search_id : Int?
    let search_params : HSearchParams?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case msg = "msg"
        case search_id = "search_id"
        case search_params = "search_params"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        search_params = try values.decodeIfPresent(HSearchParams.self, forKey: .search_params)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
}



struct HSearchParams : Codable {
    let city : String?
    let adult : [String]?
    let hotel_checkin : String?
    let hotel_checkout : String?
    let child : [String]?
    let user_id : String?
    let hotel_destination : String?
    let nationality : String?
    let rooms : String?
    
    enum CodingKeys: String, CodingKey {
        
        case city = "city"
        case adult = "adult"
        case hotel_checkin = "hotel_checkin"
        case hotel_checkout = "hotel_checkout"
        case child = "child"
        case user_id = "user_id"
        case hotel_destination = "hotel_destination"
        case nationality = "nationality"
        case rooms = "rooms"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        adult = try values.decodeIfPresent([String].self, forKey: .adult)
        hotel_checkin = try values.decodeIfPresent(String.self, forKey: .hotel_checkin)
        hotel_checkout = try values.decodeIfPresent(String.self, forKey: .hotel_checkout)
        child = try values.decodeIfPresent([String].self, forKey: .child)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        hotel_destination = try values.decodeIfPresent(String.self, forKey: .hotel_destination)
        nationality = try values.decodeIfPresent(String.self, forKey: .nationality)
        rooms = try values.decodeIfPresent(String.self, forKey: .rooms)
    }
    
}
