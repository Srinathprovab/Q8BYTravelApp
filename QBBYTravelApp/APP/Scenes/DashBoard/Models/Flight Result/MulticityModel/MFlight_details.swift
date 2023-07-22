//
//  MFlight_details.swift
//  QBBYTravelApp
//
//  Created by FCI on 12/07/23.
//

import Foundation


struct MFlight_details : Codable {
    let summary : [Summary]?

    enum CodingKeys: String, CodingKey {

        case summary = "summary"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        summary = try values.decodeIfPresent([Summary].self, forKey: .summary)
    }

}
