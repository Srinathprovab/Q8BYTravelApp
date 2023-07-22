//
//  SelectCurrencyModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 05/04/23.
//

import Foundation

struct SelectCurrencyModel : Codable {
    let data : [SelectCurrencyData]?
    let status : Bool?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([SelectCurrencyData].self, forKey: .data)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}



struct SelectCurrencyData : Codable {
    let origin : String?
    let symbol : String?
    let value : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case symbol = "symbol"
        case value = "value"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
