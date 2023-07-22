//
//  MulticityModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 12/07/23.
//

import Foundation


struct MulticityModel : Codable {
    let data : MulticityDataModel?
    let msg : String?
    let status : Int?
    let session_expiry_details : Session_expiry_details?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
        case session_expiry_details = "session_expiry_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(MulticityDataModel.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
    }

}
