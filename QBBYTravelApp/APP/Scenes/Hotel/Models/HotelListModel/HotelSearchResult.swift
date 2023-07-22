

import Foundation
struct HotelSearchResult : Codable {
    let booking_source : String?
    let hotel_code : Int?
    let city_code : String?
    let country_code : String?
    let city_name : String?
    let country_name : String?
    let name : String?
    let address : String?
    let phone_number : String?
    let fax : String?
    let email : String?
    let website : String?
    let hotel_desc : String?
    let image : String?
    let thumb_image : String?
    let accomodation_cstr : String?
    let location : String?
    let star_rating : Int?
    let latitude : String?
    let longitude : String?
    let facility_cstr : String?
    let facility : [Facility]?
    let currency : String?
    let xml_currency : String?
    let xml_net : String?
    let price : String?
    let xml_price : String?

    enum CodingKeys: String, CodingKey {

        case booking_source = "booking_source"
        case hotel_code = "hotel_code"
        case city_code = "city_code"
        case country_code = "country_code"
        case city_name = "city_name"
        case country_name = "country_name"
        case name = "name"
        case address = "address"
        case phone_number = "phone_number"
        case fax = "fax"
        case email = "email"
        case website = "website"
        case hotel_desc = "hotel_desc"
        case image = "image"
        case thumb_image = "thumb_image"
        case accomodation_cstr = "accomodation_cstr"
        case location = "location"
        case star_rating = "star_rating"
        case latitude = "latitude"
        case longitude = "longitude"
        case facility_cstr = "facility_cstr"
        case facility = "facility"
        case currency = "currency"
        case xml_currency = "xml_currency"
        case xml_net = "xml_net"
        case price = "price"
        case xml_price = "xml_price"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        hotel_code = try values.decodeIfPresent(Int.self, forKey: .hotel_code)
        city_code = try values.decodeIfPresent(String.self, forKey: .city_code)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
        fax = try values.decodeIfPresent(String.self, forKey: .fax)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        hotel_desc = try values.decodeIfPresent(String.self, forKey: .hotel_desc)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        thumb_image = try values.decodeIfPresent(String.self, forKey: .thumb_image)
        accomodation_cstr = try values.decodeIfPresent(String.self, forKey: .accomodation_cstr)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        star_rating = try values.decodeIfPresent(Int.self, forKey: .star_rating)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        facility_cstr = try values.decodeIfPresent(String.self, forKey: .facility_cstr)
        facility = try values.decodeIfPresent([Facility].self, forKey: .facility)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        xml_currency = try values.decodeIfPresent(String.self, forKey: .xml_currency)
        xml_net = try values.decodeIfPresent(String.self, forKey: .xml_net)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        xml_price = try values.decodeIfPresent(String.self, forKey: .xml_price)
    }

}
