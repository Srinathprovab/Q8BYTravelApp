//
//  HotelDetailsModel.swift
//  KuwaitWays
//
//  Created by FCI on 03/05/23.
//

import Foundation


struct HotelDetailsModel : Codable {
    let status : Bool?
    let msg : String?
    let currency_obj : Currency_obj?
    let hotel_details : Hotel_details?
//    let hotel_search_params : Hotel_search_params?
//    let active_booking_source : String?
//    let params : Params?
//    let advertisement : [String]?
//    let session_expiry_details : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case currency_obj = "currency_obj"
        case hotel_details = "hotel_details"
//        case hotel_search_params = "hotel_search_params"
//        case active_booking_source = "active_booking_source"
//        case params = "params"
//        case advertisement = "advertisement"
//        case session_expiry_details = "session_expiry_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        currency_obj = try values.decodeIfPresent(Currency_obj.self, forKey: .currency_obj)
        hotel_details = try values.decodeIfPresent(Hotel_details.self, forKey: .hotel_details)
//        hotel_search_params = try values.decodeIfPresent(Hotel_search_params.self, forKey: .hotel_search_params)
//        active_booking_source = try values.decodeIfPresent(String.self, forKey: .active_booking_source)
//        params = try values.decodeIfPresent(Params.self, forKey: .params)
//        advertisement = try values.decodeIfPresent([String].self, forKey: .advertisement)
//        session_expiry_details = try values.decodeIfPresent(String.self, forKey: .session_expiry_details)
    }

}
