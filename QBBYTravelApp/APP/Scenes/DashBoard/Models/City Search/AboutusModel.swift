//
//  AboutusModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 05/04/23.
//

import Foundation

struct AboutusModel : Codable {
    let status : Int?
    let data : [AboutusData]?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent([AboutusData].self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}



struct AboutusData : Codable {
    
    let page_title : String?
    let page_title_ar : String?
    let page_description : String?
    let page_description_ar : String?
    let page_seo_title : String?
    let page_seo_keyword : String?
    let page_seo_description : String?

    enum CodingKeys: String, CodingKey {

        case page_title = "page_title"
        case page_title_ar = "page_title_ar"
        case page_description = "page_description"
        case page_description_ar = "page_description_ar"
        case page_seo_title = "page_seo_title"
        case page_seo_keyword = "page_seo_keyword"
        case page_seo_description = "page_seo_description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page_title = try values.decodeIfPresent(String.self, forKey: .page_title)
        page_title_ar = try values.decodeIfPresent(String.self, forKey: .page_title_ar)
        page_description = try values.decodeIfPresent(String.self, forKey: .page_description)
        page_description_ar = try values.decodeIfPresent(String.self, forKey: .page_description_ar)
        page_seo_title = try values.decodeIfPresent(String.self, forKey: .page_seo_title)
        page_seo_keyword = try values.decodeIfPresent(String.self, forKey: .page_seo_keyword)
        page_seo_description = try values.decodeIfPresent(String.self, forKey: .page_seo_description)
    }

}
