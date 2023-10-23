//
//  AirlinesListModel.swift
//  KuwaitWays
//
//  Created by FCI on 18/10/23.
//

import Foundation

struct AirlinesListModel : Codable {
    let status : Bool?
    let airline_list : [Airline_list]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case airline_list = "airline_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        airline_list = try values.decodeIfPresent([Airline_list].self, forKey: .airline_list)
    }

}
