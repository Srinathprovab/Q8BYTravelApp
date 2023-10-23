//
//  LoginModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 05/04/23.
//

import Foundation


struct LoginModel : Codable {
    
    let status : Bool?
    let msg : String?
    let user_id : String?
    let data : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case user_id = "user_id"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        data = try values.decodeIfPresent(String.self, forKey: .data)
    }

}


