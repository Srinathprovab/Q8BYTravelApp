

import Foundation
struct Airline_list : Codable {
	let id : String?
	let name : String?
	let code : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case code = "code"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		code = try values.decodeIfPresent(String.self, forKey: .code)
	}

}
