//
//  VocherModel.swift
//  BabSafar
//
//  Created by FCI on 08/12/22.
//

import Foundation


struct VocherModel : Codable {
    let data : VocherModelDetails?
    let cancelltion_policy : String?
    let get_airline_pnr : Get_airline_pnr?
    let item : String?
    let flight_details : Flight_details?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case cancelltion_policy = "cancelltion_policy"
        case get_airline_pnr = "get_airline_pnr"
        case item = "item"
        case flight_details = "flight_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(VocherModelDetails.self, forKey: .data)
        cancelltion_policy = try values.decodeIfPresent(String.self, forKey: .cancelltion_policy)
        get_airline_pnr = try values.decodeIfPresent(Get_airline_pnr.self, forKey: .get_airline_pnr)
        item = try values.decodeIfPresent(String.self, forKey: .item)
        flight_details = try values.decodeIfPresent(Flight_details.self, forKey: .flight_details)
    }

}
