//
//  HMPreBookingModel.swift
//  KuwaitWays
//
//  Created by FCI on 04/05/23.
//

import Foundation

struct HMPreBookingModel : Codable {
    let status : Int?
    let msg : String?
    let data : HMPreBookingData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent(HMPreBookingData.self, forKey: .data)
    }

}



struct HMPreBookingData : Codable {
    let post_data : Post_data?

    enum CodingKeys: String, CodingKey {

        case post_data = "post_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        post_data = try values.decodeIfPresent(Post_data.self, forKey: .post_data)
    }

}
