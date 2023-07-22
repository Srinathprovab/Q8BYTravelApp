//
//  MulticityDataModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 12/07/23.
//

import Foundation


struct MulticityDataModel : Codable {
    
    let col_2x_result : Bool?
    let search_params : MSearch_params?
    let search_id : Int?
    let booking_url : String?
    let booking_source_key : String?
    let booking_source : String?
    let j_flight_list : [MJ_flight_list]?
    let journey_id : Int?
    let pxtrip_type : String?

    enum CodingKeys: String, CodingKey {

        case col_2x_result = "col_2x_result"
        case search_params = "search_params"
        case search_id = "search_id"
        case booking_url = "booking_url"
        case booking_source_key = "booking_source_key"
        case booking_source = "booking_source"
        case j_flight_list = "j_flight_list"
        case journey_id = "journey_id"
        case pxtrip_type = "pxtrip_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        col_2x_result = try values.decodeIfPresent(Bool.self, forKey: .col_2x_result)
        search_params = try values.decodeIfPresent(MSearch_params.self, forKey: .search_params)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        booking_url = try values.decodeIfPresent(String.self, forKey: .booking_url)
        booking_source_key = try values.decodeIfPresent(String.self, forKey: .booking_source_key)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        j_flight_list = try values.decodeIfPresent([MJ_flight_list].self, forKey: .j_flight_list)
        journey_id = try values.decodeIfPresent(Int.self, forKey: .journey_id)
        pxtrip_type = try values.decodeIfPresent(String.self, forKey: .pxtrip_type)
    }

}
