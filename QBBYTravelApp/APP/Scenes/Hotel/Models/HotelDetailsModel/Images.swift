

import Foundation
struct Images : Codable {
	let img : String?

	enum CodingKeys: String, CodingKey {

		case img = "img"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		img = try values.decodeIfPresent(String.self, forKey: .img)
	}

}
