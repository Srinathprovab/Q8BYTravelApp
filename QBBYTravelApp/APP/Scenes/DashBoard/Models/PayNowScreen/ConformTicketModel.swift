//
//  ConformTicketModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 03/07/23.
//

import Foundation


struct ConformTicketModel : Codable {
    let url : String?
    let msg : String?
    let Status : Bool?

    enum CodingKeys: String, CodingKey {

        case url = "URL"
        case msg = "msg"
        case Status = "Status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        Status = try values.decodeIfPresent(Bool.self, forKey: .Status)
    }

}
