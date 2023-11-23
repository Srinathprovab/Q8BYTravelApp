//
//  HotelListModel.swift
//  KuwaitWays
//
//  Created by FCI on 02/05/23.
//

import Foundation


struct HotelListModel : Codable {
    let data : HotelListData?
    let status : Int?
    let msg : String?
    let filter_result_count : Int?
    let offset : Int?
    let search_id : String?
    let session_expiry_details : Session_expiry_details?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case msg = "msg"
        case filter_result_count = "filter_result_count"
        case offset = "offset"
        case search_id = "search_id"
        case session_expiry_details = "session_expiry_details"
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(HotelListData.self, forKey: .data)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        filter_result_count = try values.decodeIfPresent(Int.self, forKey: .filter_result_count)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
    }

}



struct HotelListData : Codable {
    let hotelSearchResult : [HotelSearchResult]?

    enum CodingKeys: String, CodingKey {

        case hotelSearchResult = "HotelSearchResult"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hotelSearchResult = try values.decodeIfPresent([HotelSearchResult].self, forKey: .hotelSearchResult)
    }

}
