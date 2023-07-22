//
//  HolidayDetailsModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 24/05/23.
//

import Foundation

struct HolidayDetailsModel : Codable {
    
    let tour_data : Tour_data?
    let get_flight_details_onward_on : Bool?
    let get_fl_on : String?
    let get_fl_on_1 : String?
    let get_flight_details_onward : String?
    let get_flight_details_return_ret : Bool?
    let get_fl_ret : String?
    let get_fl_ret_1 : String?
    let get_flight_details_return : String?
    let get_flight : String?
    let get_flight_ret : Get_flight_ret?
    let boarditnow_fare_rules : Boarditnow_fare_rules?
    let tours_itinerary : Tours_itinerary?
    let tours_itinerary_dw : [Tours_itinerary_dw]?
    let tours_date_price : [Tours_date_price]?
    let tours_continent : [Tours_continent]?
    let tour_type : [Tour_type]?
    let tour_theme : [Tour_theme]?
    //   let tours_continent_name : Tours_continent_name?
    let tour_price : [Tour_price]?
    let tour_dep_dates_list : [Tour_dep_dates_list]?
    let tour_price_changed : [Tour_price_changed]?
    let min_price : Int?
    let date_array : [String]?
    let post_review_data : Post_review_data?
    let tour_id : String?
    let search_id : String?
    
    enum CodingKeys: String, CodingKey {
        
        case tour_data = "tour_data"
        case get_flight_details_onward_on = "get_flight_details_onward_on"
        case get_fl_on = "get_fl_on"
        case get_fl_on_1 = "get_fl_on_1"
        case get_flight_details_onward = "get_flight_details_onward"
        case get_flight_details_return_ret = "get_flight_details_return_ret"
        case get_fl_ret = "get_fl_ret"
        case get_fl_ret_1 = "get_fl_ret_1"
        case get_flight_details_return = "get_flight_details_return"
        case get_flight = "get_flight"
        case get_flight_ret = "get_flight_ret"
        case boarditnow_fare_rules = "boarditnow_fare_rules"
        case tours_itinerary = "tours_itinerary"
        case tours_itinerary_dw = "tours_itinerary_dw"
        case tours_date_price = "tours_date_price"
        case tours_continent = "tours_continent"
        case tour_type = "tour_type"
        case tour_theme = "tour_theme"
        //       case tours_continent_name = "tours_continent_name"
        case tour_price = "tour_price"
        case tour_dep_dates_list = "tour_dep_dates_list"
        case tour_price_changed = "tour_price_changed"
        case min_price = "min_price"
        case date_array = "date_array"
        case post_review_data = "post_review_data"
        case tour_id = "tour_id"
        case search_id = "search_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tour_data = try values.decodeIfPresent(Tour_data.self, forKey: .tour_data)
        get_flight_details_onward_on = try values.decodeIfPresent(Bool.self, forKey: .get_flight_details_onward_on)
        get_fl_on = try values.decodeIfPresent(String.self, forKey: .get_fl_on)
        get_fl_on_1 = try values.decodeIfPresent(String.self, forKey: .get_fl_on_1)
        get_flight_details_onward = try values.decodeIfPresent(String.self, forKey: .get_flight_details_onward)
        get_flight_details_return_ret = try values.decodeIfPresent(Bool.self, forKey: .get_flight_details_return_ret)
        get_fl_ret = try values.decodeIfPresent(String.self, forKey: .get_fl_ret)
        get_fl_ret_1 = try values.decodeIfPresent(String.self, forKey: .get_fl_ret_1)
        get_flight_details_return = try values.decodeIfPresent(String.self, forKey: .get_flight_details_return)
        get_flight = try values.decodeIfPresent(String.self, forKey: .get_flight)
        get_flight_ret = try values.decodeIfPresent(Get_flight_ret.self, forKey: .get_flight_ret)
        boarditnow_fare_rules = try values.decodeIfPresent(Boarditnow_fare_rules.self, forKey: .boarditnow_fare_rules)
        tours_itinerary = try values.decodeIfPresent(Tours_itinerary.self, forKey: .tours_itinerary)
        tours_itinerary_dw = try values.decodeIfPresent([Tours_itinerary_dw].self, forKey: .tours_itinerary_dw)
        tours_date_price = try values.decodeIfPresent([Tours_date_price].self, forKey: .tours_date_price)
        tours_continent = try values.decodeIfPresent([Tours_continent].self, forKey: .tours_continent)
        tour_type = try values.decodeIfPresent([Tour_type].self, forKey: .tour_type)
        tour_theme = try values.decodeIfPresent([Tour_theme].self, forKey: .tour_theme)
        //      tours_continent_name = try values.decodeIfPresent(Tours_continent_name.self, forKey: .tours_continent_name)
        tour_price = try values.decodeIfPresent([Tour_price].self, forKey: .tour_price)
        tour_dep_dates_list = try values.decodeIfPresent([Tour_dep_dates_list].self, forKey: .tour_dep_dates_list)
        tour_price_changed = try values.decodeIfPresent([Tour_price_changed].self, forKey: .tour_price_changed)
        min_price = try values.decodeIfPresent(Int.self, forKey: .min_price)
        date_array = try values.decodeIfPresent([String].self, forKey: .date_array)
        post_review_data = try values.decodeIfPresent(Post_review_data.self, forKey: .post_review_data)
        tour_id = try values.decodeIfPresent(String.self, forKey: .tour_id)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
    }
    
}
