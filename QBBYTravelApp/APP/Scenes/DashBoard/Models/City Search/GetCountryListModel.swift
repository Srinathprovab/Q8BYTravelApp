//
//  GetCountryListModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 19/04/23.
//

import Foundation


import Foundation
struct GetCountryListModel : Codable {
    let data : CountryData?
    let status : Bool?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(CountryData.self, forKey: .data)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}


struct CountryData : Codable {
    let country_list : [Country_list]?

    enum CodingKeys: String, CodingKey {

        case country_list = "country_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        country_list = try values.decodeIfPresent([Country_list].self, forKey: .country_list)
    }

}



struct Country_list : Codable {
    let origin : String?
    let api_continent_list_fk : String?
    let name : String?
    let country_code : String?
    let iso_country_code : String?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case api_continent_list_fk = "api_continent_list_fk"
        case name = "name"
        case country_code = "country_code"
        case iso_country_code = "iso_country_code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        api_continent_list_fk = try values.decodeIfPresent(String.self, forKey: .api_continent_list_fk)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        iso_country_code = try values.decodeIfPresent(String.self, forKey: .iso_country_code)
    }

}
