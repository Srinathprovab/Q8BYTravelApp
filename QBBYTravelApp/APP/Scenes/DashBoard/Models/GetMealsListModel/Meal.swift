

import Foundation
struct Meal : Codable {
    
	let origin : String?
	let code : String?
	let description : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case code = "code"
		case description = "description"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		code = try values.decodeIfPresent(String.self, forKey: .code)
		description = try values.decodeIfPresent(String.self, forKey: .description)
	}

}
