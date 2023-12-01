//
//  ApplyPromocodeModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 01/12/23.
//

import Foundation


struct ApplyPromocodeModel : Codable {
    let value : String?
    let total_amount_val : String?
    let total_amount_val_CAD : Double?
    let convenience_fee : String?
    let promocode : String?
    let status : Int?

    enum CodingKeys: String, CodingKey {

        case value = "value"
        case total_amount_val = "total_amount_val"
        case total_amount_val_CAD = "total_amount_val_CAD"
        case convenience_fee = "convenience_fee"
        case promocode = "promocode"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        total_amount_val = try values.decodeIfPresent(String.self, forKey: .total_amount_val)
        total_amount_val_CAD = try values.decodeIfPresent(Double.self, forKey: .total_amount_val_CAD)
        convenience_fee = try values.decodeIfPresent(String.self, forKey: .convenience_fee)
        promocode = try values.decodeIfPresent(String.self, forKey: .promocode)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}
