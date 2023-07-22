//
//  GetMealsListModel.swift
//  KuwaitWays
//
//  Created by FCI on 24/05/23.
//

import Foundation


struct GetMealsListModel : Codable {
    let meal : [Meal]?
    let status : Int?

    enum CodingKeys: String, CodingKey {

        case meal = "meal"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        meal = try values.decodeIfPresent([Meal].self, forKey: .meal)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}
