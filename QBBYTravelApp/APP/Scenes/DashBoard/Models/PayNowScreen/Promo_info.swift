

import Foundation
struct Promo_info : Codable {
	let description : String?
	let created_by_id : String?
	let use_type : String?
	let start_date : String?
	let expiry_date : String?
	let limitation : String?
	let created_datetime : String?
	let value : String?
	let module : String?
	let promo_code : String?
	let origin : String?
	let value_type : String?
	let image_path : String?
	let publish_status : String?
	let amt_min : String?
	let status : String?

	enum CodingKeys: String, CodingKey {

		case description = "description"
		case created_by_id = "created_by_id"
		case use_type = "use_type"
		case start_date = "start_date"
		case expiry_date = "expiry_date"
		case limitation = "limitation"
		case created_datetime = "created_datetime"
		case value = "value"
		case module = "module"
		case promo_code = "promo_code"
		case origin = "origin"
		case value_type = "value_type"
		case image_path = "image_path"
		case publish_status = "publish_status"
		case amt_min = "amt_min"
		case status = "status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
		use_type = try values.decodeIfPresent(String.self, forKey: .use_type)
		start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
		expiry_date = try values.decodeIfPresent(String.self, forKey: .expiry_date)
		limitation = try values.decodeIfPresent(String.self, forKey: .limitation)
		created_datetime = try values.decodeIfPresent(String.self, forKey: .created_datetime)
		value = try values.decodeIfPresent(String.self, forKey: .value)
		module = try values.decodeIfPresent(String.self, forKey: .module)
		promo_code = try values.decodeIfPresent(String.self, forKey: .promo_code)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		value_type = try values.decodeIfPresent(String.self, forKey: .value_type)
		image_path = try values.decodeIfPresent(String.self, forKey: .image_path)
		publish_status = try values.decodeIfPresent(String.self, forKey: .publish_status)
		amt_min = try values.decodeIfPresent(String.self, forKey: .amt_min)
		status = try values.decodeIfPresent(String.self, forKey: .status)
	}

}
