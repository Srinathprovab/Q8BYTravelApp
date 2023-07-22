//
//  HotelMBSearchData.swift
//  KuwaitWays
//
//  Created by FCI on 04/05/23.
//

import Foundation


struct HotelMBSearchData : Codable {
    let from_date : String?
    let to_date : String?
    let no_of_nights : Int?
    let hotel_destination : String?
    let location : String?
    let city_name : String?
    let country_name : String?
    let room_count : Int?
//    let adult_config : [String]?
//    let child_config : [String]?
    let is_domestic : Bool?
    let nationality : String?
    let lang : String?
    let search_id : Int?
    let hotel_checkin_date : String?
    let hotel_checkout_date : String?
    let total_pax_count : Int?

    enum CodingKeys: String, CodingKey {

        case from_date = "from_date"
        case to_date = "to_date"
        case no_of_nights = "no_of_nights"
        case hotel_destination = "hotel_destination"
        case location = "location"
        case city_name = "city_name"
        case country_name = "country_name"
        case room_count = "room_count"
//        case adult_config = "adult_config"
//        case child_config = "child_config"
        case is_domestic = "is_domestic"
        case nationality = "nationality"
        case lang = "lang"
        case search_id = "search_id"
        case hotel_checkin_date = "hotel_checkin_date"
        case hotel_checkout_date = "hotel_checkout_date"
        case total_pax_count = "total_pax_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        from_date = try values.decodeIfPresent(String.self, forKey: .from_date)
        to_date = try values.decodeIfPresent(String.self, forKey: .to_date)
        no_of_nights = try values.decodeIfPresent(Int.self, forKey: .no_of_nights)
        hotel_destination = try values.decodeIfPresent(String.self, forKey: .hotel_destination)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        room_count = try values.decodeIfPresent(Int.self, forKey: .room_count)
//        adult_config = try values.decodeIfPresent([String].self, forKey: .adult_config)
//        child_config = try values.decodeIfPresent([String].self, forKey: .child_config)
        is_domestic = try values.decodeIfPresent(Bool.self, forKey: .is_domestic)
        nationality = try values.decodeIfPresent(String.self, forKey: .nationality)
        lang = try values.decodeIfPresent(String.self, forKey: .lang)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        hotel_checkin_date = try values.decodeIfPresent(String.self, forKey: .hotel_checkin_date)
        hotel_checkout_date = try values.decodeIfPresent(String.self, forKey: .hotel_checkout_date)
        total_pax_count = try values.decodeIfPresent(Int.self, forKey: .total_pax_count)
    }

}
