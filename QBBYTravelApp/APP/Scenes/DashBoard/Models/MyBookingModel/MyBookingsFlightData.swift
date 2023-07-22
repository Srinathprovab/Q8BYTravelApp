//
//  MyBookingsFlightData.swift
//  KuwaitWays
//
//  Created by FCI on 08/05/23.
//

import Foundation


struct MyBookingsFlightData : Codable {
    let summary : [Summary]?
    let transaction : Transaction?

    enum CodingKeys: String, CodingKey {

        case summary = "summary"
        case transaction = "transaction"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        summary = try values.decodeIfPresent([Summary].self, forKey: .summary)
        transaction = try values.decodeIfPresent(Transaction.self, forKey: .transaction)
    }

}
