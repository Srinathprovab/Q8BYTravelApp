

import Foundation
struct Pre_booking_params : Codable {
	let search_id : String?
	let booking_source : String?
	let user_id : String?
	let promocode_val : String?
	let access_key : String?

	enum CodingKeys: String, CodingKey {

		case search_id = "search_id"
		case booking_source = "booking_source"
		case user_id = "user_id"
		case promocode_val = "promocode_val"
		case access_key = "access_key"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
		booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
		user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
		promocode_val = try values.decodeIfPresent(String.self, forKey: .promocode_val)
		access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
	}

}
