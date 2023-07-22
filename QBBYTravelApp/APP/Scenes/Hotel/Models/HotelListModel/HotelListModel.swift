//
//  HotelListModel.swift
//  KuwaitWays
//
//  Created by FCI on 02/05/23.
//

import Foundation


struct HotelListModel : Codable {
    let data : HotelListData?
    let msg : String?
    let status : Int?
    let offset : Int?
    let booking_source : String?
    let search_id : Int?
    let session_expiry_details : Session_expiry_details?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
        case offset = "offset"
        case booking_source = "booking_source"
        case search_id = "search_id"
        case session_expiry_details = "session_expiry_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(HotelListData.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
    }

}



struct HotelListData : Codable {
    let hotelSearchResult : [HotelSearchResult]?
    let source_result_count : Int?
    let filter_result_count : Int?

    enum CodingKeys: String, CodingKey {

        case hotelSearchResult = "HotelSearchResult"
        case source_result_count = "source_result_count"
        case filter_result_count = "filter_result_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hotelSearchResult = try values.decodeIfPresent([HotelSearchResult].self, forKey: .hotelSearchResult)
        source_result_count = try values.decodeIfPresent(Int.self, forKey: .source_result_count)
        filter_result_count = try values.decodeIfPresent(Int.self, forKey: .filter_result_count)
    }

}
