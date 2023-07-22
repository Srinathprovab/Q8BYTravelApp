//
//  HolidayCitySearchModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 24/05/23.
//

import Foundation



struct HolidayCitySearchModel : Codable {
    let name : String?
    let value : String?
    let details : String?
    let id : String?
    let category : String?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case value = "value"
        case details = "details"
        case id = "id"
        case category = "category"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        details = try values.decodeIfPresent(String.self, forKey: .details)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}
