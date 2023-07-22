//
//  FlightBookingModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 20/04/23.
//

import Foundation


struct FlightBookingModel : Codable {
    
    let access_key_tp : String?
    let flight_data : [Flight_data]?
    let active_payment_options : [String]?
    let booking_source : String?
    let tmp_flight_pre_booking_id : String?
    let pre_booking_params : Pre_booking_params?
    //    let iso_country_list : Iso_country_list?
    let country_list : Country_list?
    let form_params : Form_params?
    //    let search_data : Search_data?
    let pax_details : Bool?
    //    let country_code : Country_code?
    let travel_date_diff : String?
    let session_expiry_details : Session_expiry_details?
    //    let app_supported_currency : App_supported_currency?
    //    let app_supported_currency_usd : App_supported_currency_usd?
    let converted_currency_rate : Int?
    //   let baggage_citiesps : Baggage_citiesps?
    let flight_terms_cancellation_policy : String?
    let convenience_fees : Int?
    let total_price : Double?
    let reward_usable : Int?
    let reward_earned : Int?
    let total_price_with_rewards : Int?
    //   let domain_list : [Domain_list]?
    let status : Int?
    let msg : String?
    
    enum CodingKeys: String, CodingKey {
        
        case access_key_tp = "access_key_tp"
        case flight_data = "flight_data"
        case active_payment_options = "active_payment_options"
        case booking_source = "booking_source"
        case tmp_flight_pre_booking_id = "tmp_flight_pre_booking_id"
        case pre_booking_params = "pre_booking_params"
        //    case iso_country_list = "iso_country_list"
        case country_list = "country_list"
        case form_params = "form_params"
        //     case search_data = "search_data"
        case pax_details = "pax_details"
        //      case country_code = "country_code"
        case travel_date_diff = "travel_date_diff"
        case session_expiry_details = "session_expiry_details"
        //        case app_supported_currency = "app_supported_currency"
        //        case app_supported_currency_usd = "app_supported_currency_usd"
        case converted_currency_rate = "converted_currency_rate"
        //      case baggage_citiesps = "baggage_citiesps"
        case flight_terms_cancellation_policy = "flight_terms_cancellation_policy"
        case convenience_fees = "convenience_fees"
        case total_price = "total_price"
        case reward_usable = "reward_usable"
        case reward_earned = "reward_earned"
        case total_price_with_rewards = "total_price_with_rewards"
        //     case domain_list = "domain_list"
        case status = "status"
        case msg = "msg"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        access_key_tp = try values.decodeIfPresent(String.self, forKey: .access_key_tp)
        flight_data = try values.decodeIfPresent([Flight_data].self, forKey: .flight_data)
        active_payment_options = try values.decodeIfPresent([String].self, forKey: .active_payment_options)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        tmp_flight_pre_booking_id = try values.decodeIfPresent(String.self, forKey: .tmp_flight_pre_booking_id)
        pre_booking_params = try values.decodeIfPresent(Pre_booking_params.self, forKey: .pre_booking_params)
        //      iso_country_list = try values.decodeIfPresent(Iso_country_list.self, forKey: .iso_country_list)
        country_list = try values.decodeIfPresent(Country_list.self, forKey: .country_list)
        form_params = try values.decodeIfPresent(Form_params.self, forKey: .form_params)
        //     search_data = try values.decodeIfPresent(Search_data.self, forKey: .search_data)
        pax_details = try values.decodeIfPresent(Bool.self, forKey: .pax_details)
        //      country_code = try values.decodeIfPresent(Country_code.self, forKey: .country_code)
        travel_date_diff = try values.decodeIfPresent(String.self, forKey: .travel_date_diff)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
        //        app_supported_currency = try values.decodeIfPresent(App_supported_currency.self, forKey: .app_supported_currency)
        //        app_supported_currency_usd = try values.decodeIfPresent(App_supported_currency_usd.self, forKey: .app_supported_currency_usd)
        converted_currency_rate = try values.decodeIfPresent(Int.self, forKey: .converted_currency_rate)
        //     baggage_citiesps = try values.decodeIfPresent(Baggage_citiesps.self, forKey: .baggage_citiesps)
        flight_terms_cancellation_policy = try values.decodeIfPresent(String.self, forKey: .flight_terms_cancellation_policy)
        convenience_fees = try values.decodeIfPresent(Int.self, forKey: .convenience_fees)
        total_price = try values.decodeIfPresent(Double.self, forKey: .total_price)
        reward_usable = try values.decodeIfPresent(Int.self, forKey: .reward_usable)
        reward_earned = try values.decodeIfPresent(Int.self, forKey: .reward_earned)
        total_price_with_rewards = try values.decodeIfPresent(Int.self, forKey: .total_price_with_rewards)
        //     domain_list = try values.decodeIfPresent([Domain_list].self, forKey: .domain_list)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }
    
}
