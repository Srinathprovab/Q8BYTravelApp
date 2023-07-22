//
//  HotelSecureBookingModel.swift
//  KuwaitWays
//
//  Created by FCI on 04/05/23.
//

import Foundation

struct HotelSecureBookingModel : Codable {
    let status : Int?
    let message : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}
