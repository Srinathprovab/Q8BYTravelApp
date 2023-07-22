

import Foundation
struct PriceDetails : Codable {
    let api_currency : String?
    let infantTaxPrice : String?
    let adultsTotalPrice : String?
    let childBasePrice : String?
    let adultsTaxPrice : String?
    let childTaxPrice : String?
    let childTotalPrice : String?
    let infantTotalPrice : String?
    let sub_total_adult : String?
    let sub_total_child : String?
    let adultsBasePrice : String?
    let no_of_passegers : Int?
    let sub_total_infant : String?
    let grand_total : String?
    let infantBasePrice : String?

    enum CodingKeys: String, CodingKey {

        case api_currency = "api_currency"
        case infantTaxPrice = "infantTaxPrice"
        case adultsTotalPrice = "adultsTotalPrice"
        case childBasePrice = "childBasePrice"
        case adultsTaxPrice = "adultsTaxPrice"
        case childTaxPrice = "childTaxPrice"
        case childTotalPrice = "childTotalPrice"
        case infantTotalPrice = "infantTotalPrice"
        case sub_total_adult = "sub_total_adult"
        case sub_total_child = "sub_total_child"
        case adultsBasePrice = "adultsBasePrice"
        case no_of_passegers = "no_of_passegers"
        case sub_total_infant = "sub_total_infant"
        case grand_total = "grand_total"
        case infantBasePrice = "infantBasePrice"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        api_currency = try values.decodeIfPresent(String.self, forKey: .api_currency)
        infantTaxPrice = try values.decodeIfPresent(String.self, forKey: .infantTaxPrice)
        adultsTotalPrice = try values.decodeIfPresent(String.self, forKey: .adultsTotalPrice)
        childBasePrice = try values.decodeIfPresent(String.self, forKey: .childBasePrice)
        adultsTaxPrice = try values.decodeIfPresent(String.self, forKey: .adultsTaxPrice)
        childTaxPrice = try values.decodeIfPresent(String.self, forKey: .childTaxPrice)
        childTotalPrice = try values.decodeIfPresent(String.self, forKey: .childTotalPrice)
        infantTotalPrice = try values.decodeIfPresent(String.self, forKey: .infantTotalPrice)
        sub_total_adult = try values.decodeIfPresent(String.self, forKey: .sub_total_adult)
        sub_total_child = try values.decodeIfPresent(String.self, forKey: .sub_total_child)
        adultsBasePrice = try values.decodeIfPresent(String.self, forKey: .adultsBasePrice)
        no_of_passegers = try values.decodeIfPresent(Int.self, forKey: .no_of_passegers)
        sub_total_infant = try values.decodeIfPresent(String.self, forKey: .sub_total_infant)
        grand_total = try values.decodeIfPresent(String.self, forKey: .grand_total)
        infantBasePrice = try values.decodeIfPresent(String.self, forKey: .infantBasePrice)
    }

}
