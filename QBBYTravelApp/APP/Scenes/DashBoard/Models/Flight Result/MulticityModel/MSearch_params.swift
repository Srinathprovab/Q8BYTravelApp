//
//  MSearch_params.swift
//  QBBYTravelApp
//
//  Created by FCI on 12/07/23.
//

import Foundation


struct MSearch_params : Codable {
    let trip_type : String?
    let trip_type_label : String?
    let depature : [String]?
    let from : [String]?
    let from_loc : [String]?
    let from_loc_id : [String]?
    let to : [String]?
    let to_loc : [String]?
    let to_loc_id : [String]?
    let is_domestic : Bool?
    let total_pax : Int?
    let adult_config : String?
    let child_config : String?
    let infant_config : String?
    let v_class : String?
    let carrier : String?
    let deal_type : String?

    enum CodingKeys: String, CodingKey {

        case trip_type = "trip_type"
        case trip_type_label = "trip_type_label"
        case depature = "depature"
        case from = "from"
        case from_loc = "from_loc"
        case from_loc_id = "from_loc_id"
        case to = "to"
        case to_loc = "to_loc"
        case to_loc_id = "to_loc_id"
        case is_domestic = "is_domestic"
        case total_pax = "total_pax"
        case adult_config = "adult_config"
        case child_config = "child_config"
        case infant_config = "infant_config"
        case v_class = "v_class"
        case carrier = "carrier"
        case deal_type = "deal_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
        trip_type_label = try values.decodeIfPresent(String.self, forKey: .trip_type_label)
        depature = try values.decodeIfPresent([String].self, forKey: .depature)
        from = try values.decodeIfPresent([String].self, forKey: .from)
        from_loc = try values.decodeIfPresent([String].self, forKey: .from_loc)
        from_loc_id = try values.decodeIfPresent([String].self, forKey: .from_loc_id)
        to = try values.decodeIfPresent([String].self, forKey: .to)
        to_loc = try values.decodeIfPresent([String].self, forKey: .to_loc)
        to_loc_id = try values.decodeIfPresent([String].self, forKey: .to_loc_id)
        is_domestic = try values.decodeIfPresent(Bool.self, forKey: .is_domestic)
        total_pax = try values.decodeIfPresent(Int.self, forKey: .total_pax)
        adult_config = try values.decodeIfPresent(String.self, forKey: .adult_config)
        child_config = try values.decodeIfPresent(String.self, forKey: .child_config)
        infant_config = try values.decodeIfPresent(String.self, forKey: .infant_config)
        v_class = try values.decodeIfPresent(String.self, forKey: .v_class)
        carrier = try values.decodeIfPresent(String.self, forKey: .carrier)
        deal_type = try values.decodeIfPresent(String.self, forKey: .deal_type)
    }

}
