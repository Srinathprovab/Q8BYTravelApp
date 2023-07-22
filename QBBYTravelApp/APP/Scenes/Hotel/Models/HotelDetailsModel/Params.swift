
import Foundation
struct Params : Codable {
	let booking_source : String?
	let hotel_id : String?
	let search_id : String?

	enum CodingKeys: String, CodingKey {

		case booking_source = "booking_source"
		case hotel_id = "hotel_id"
		case search_id = "search_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
		hotel_id = try values.decodeIfPresent(String.self, forKey: .hotel_id)
		search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
	}

}
