




import Foundation
struct SelectCityModel : Codable {
    let label : String?
    let value : String?
    let id : String?
    let city_code : String?
    let airport_code : String?
    let airport_city : String?
    let airport_name : String?
    let category : String?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case label = "label"
        case value = "value"
        case id = "id"
        case city_code = "city_code"
        case airport_code = "airport_code"
        case airport_city = "airport_city"
        case airport_name = "airport_name"
        case category = "category"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        city_code = try values.decodeIfPresent(String.self, forKey: .city_code)
        airport_code = try values.decodeIfPresent(String.self, forKey: .airport_code)
        airport_city = try values.decodeIfPresent(String.self, forKey: .airport_city)
        airport_name = try values.decodeIfPresent(String.self, forKey: .airport_name)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}
