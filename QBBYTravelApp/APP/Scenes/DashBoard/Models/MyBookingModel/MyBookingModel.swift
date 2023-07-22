//
//  MyBookingModel.swift
//  KuwaitWays
//
//  Created by FCI on 08/05/23.
//

import Foundation


struct MyBookingModel : Codable {
    let res_data : [Res_data]?
    let flight_data : [MyBookingsFlightData]?

    enum CodingKeys: String, CodingKey {

        case res_data = "res_data"
        case flight_data = "flight_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        res_data = try values.decodeIfPresent([Res_data].self, forKey: .res_data)
        flight_data = try values.decodeIfPresent([MyBookingsFlightData].self, forKey: .flight_data)
    }

}
