//
//  PreBookingModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 19/04/23.
//

import Foundation


struct PreBookingModel : Codable {
    
    let form_params : Form_params?
    let form_url : String?
    let status : Bool?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case form_params = "form_params"
        case form_url = "form_url"
        case status = "status"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        form_params = try values.decodeIfPresent(Form_params.self, forKey: .form_params)
        form_url = try values.decodeIfPresent(String.self, forKey: .form_url)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}



struct Form_params : Codable {
    let promocode_discount_val : String?
    let promocode_discount_type : String?
    let token_key : String?
    let booking_source : String?
    let booking_id : String?
    let search_id : String?
    
    
    enum CodingKeys: String, CodingKey {

        case promocode_discount_val = "promocode_discount_val"
        case promocode_discount_type = "promocode_discount_type"
        case token_key = "token_key"
        case booking_source = "booking_source"
        case booking_id = "booking_id"
        case search_id = "search_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        promocode_discount_val = try values.decodeIfPresent(String.self, forKey: .promocode_discount_val)
        promocode_discount_type = try values.decodeIfPresent(String.self, forKey: .promocode_discount_type)
        token_key = try values.decodeIfPresent(String.self, forKey: .token_key)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        booking_id = try values.decodeIfPresent(String.self, forKey: .booking_id)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
    }

}
