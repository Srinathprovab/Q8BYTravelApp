//
//  ActiveBookingSourceModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 22/11/23.
//

import Foundation


struct ActiveBookingSourceModel : Codable {
    let status : Bool?
    let msg : String?
    let data : [BookingSourceData]?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent([BookingSourceData].self, forKey: .data)
    }
    
}



struct BookingSourceData : Codable {
    
    let source_id : String?
    let origin : String?
    
    enum CodingKeys: String, CodingKey {
        
        case source_id = "source_id"
        case origin = "origin"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        source_id = try values.decodeIfPresent(String.self, forKey: .source_id)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
    }
    
}
