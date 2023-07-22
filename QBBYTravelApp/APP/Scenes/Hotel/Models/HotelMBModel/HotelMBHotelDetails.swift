//
//  HotelMBHotelDetails.swift
//  KuwaitWays
//
//  Created by FCI on 04/05/23.
//

import Foundation


struct HotelMBHotelDetails : Codable {
    
    let hotel_code : Int?
    let name : String?
    let address : String?
    let image : String?
    let thumb_image : String?
    let star_rating : Int?
    let checkIn : String?
    let checkOut : String?
    let price : String?

    enum CodingKeys: String, CodingKey {

        case hotel_code = "hotel_code"
        case name = "name"
        case address = "address"
        case image = "image"
        case thumb_image = "thumb_image"
        case star_rating = "star_rating"
        case checkIn = "checkIn"
        case checkOut = "checkOut"
        case price = "price"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hotel_code = try values.decodeIfPresent(Int.self, forKey: .hotel_code)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        thumb_image = try values.decodeIfPresent(String.self, forKey: .thumb_image)
        star_rating = try values.decodeIfPresent(Int.self, forKey: .star_rating)
        checkIn = try values.decodeIfPresent(String.self, forKey: .checkIn)
        checkOut = try values.decodeIfPresent(String.self, forKey: .checkOut)
        price = try values.decodeIfPresent(String.self, forKey: .price)
    }

}
