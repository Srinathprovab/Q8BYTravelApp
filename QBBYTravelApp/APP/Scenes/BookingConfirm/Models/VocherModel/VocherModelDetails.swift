//
//  VocherModelDetails.swift
//  BabSafar
//
//  Created by FCI on 08/12/22.
//

import Foundation


struct VocherModelDetails : Codable {
    let booking_details : [Booking_details]?
    let v_class : String?
    let insurance : String?
    let insurance_totalprice : [String]?

    enum CodingKeys: String, CodingKey {

        case booking_details = "booking_details"
        case v_class = "v_class"
        case insurance = "insurance"
        case insurance_totalprice = "insurance_totalprice"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_details = try values.decodeIfPresent([Booking_details].self, forKey: .booking_details)
        v_class = try values.decodeIfPresent(String.self, forKey: .v_class)
        insurance = try values.decodeIfPresent(String.self, forKey: .insurance)
        insurance_totalprice = try values.decodeIfPresent([String].self, forKey: .insurance_totalprice)
    }

}
