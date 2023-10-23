//
//  RegisterUserModel.swift
//  KuwaitWays
//
//  Created by FCI on 24/04/23.
//

import Foundation



struct RegisterUserModel : Codable {
    let status : Bool?
    let msg : String?
    let data : RegisterUserModelData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent(RegisterUserModelData.self, forKey: .data)
    }

}




struct RegisterUserModelData : Codable {
    
    let user_id : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case user_id = "user_id"
        case status = "status"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
    
}
