

import Foundation
struct Session_expiry_details : Codable {
	let session_start_time : Int?
	let search_hash : String?

	enum CodingKeys: String, CodingKey {

		case session_start_time = "session_start_time"
		case search_hash = "search_hash"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		session_start_time = try values.decodeIfPresent(Int.self, forKey: .session_start_time)
		search_hash = try values.decodeIfPresent(String.self, forKey: .search_hash)
	}

}
