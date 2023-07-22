

import Foundation
struct Booking_customer_details : Codable {
	let origin : String?
	let app_reference : String?
	let flight_booking_transaction_details_fk : String?
	let pax_index : String?
	let segment_indicator : String?
	let passenger_type : String?
	let is_lead : String?
	let title : String?
	let first_name : String?
	let middle_name : String?
	let last_name : String?
	let date_of_birth : String?
	let gender : String?
	let passenger_nationality : String?
	let passport_number : String?
	let passport_issuing_country : String?
	let passport_expiry_date : String?
	let ff_no : String?
	let ticket_no : String?
	let oneway_bag : String?
	let return_bag : String?
	let status : String?
	let attributes : String?
	let mailing_status : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case app_reference = "app_reference"
		case flight_booking_transaction_details_fk = "flight_booking_transaction_details_fk"
		case pax_index = "pax_index"
		case segment_indicator = "segment_indicator"
		case passenger_type = "passenger_type"
		case is_lead = "is_lead"
		case title = "title"
		case first_name = "first_name"
		case middle_name = "middle_name"
		case last_name = "last_name"
		case date_of_birth = "date_of_birth"
		case gender = "gender"
		case passenger_nationality = "passenger_nationality"
		case passport_number = "passport_number"
		case passport_issuing_country = "passport_issuing_country"
		case passport_expiry_date = "passport_expiry_date"
		case ff_no = "ff_no"
		case ticket_no = "ticket_no"
		case oneway_bag = "oneway_bag"
		case return_bag = "return_bag"
		case status = "status"
		case attributes = "attributes"
		case mailing_status = "mailing_status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
		flight_booking_transaction_details_fk = try values.decodeIfPresent(String.self, forKey: .flight_booking_transaction_details_fk)
		pax_index = try values.decodeIfPresent(String.self, forKey: .pax_index)
		segment_indicator = try values.decodeIfPresent(String.self, forKey: .segment_indicator)
		passenger_type = try values.decodeIfPresent(String.self, forKey: .passenger_type)
		is_lead = try values.decodeIfPresent(String.self, forKey: .is_lead)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
		middle_name = try values.decodeIfPresent(String.self, forKey: .middle_name)
		last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
		date_of_birth = try values.decodeIfPresent(String.self, forKey: .date_of_birth)
		gender = try values.decodeIfPresent(String.self, forKey: .gender)
		passenger_nationality = try values.decodeIfPresent(String.self, forKey: .passenger_nationality)
		passport_number = try values.decodeIfPresent(String.self, forKey: .passport_number)
		passport_issuing_country = try values.decodeIfPresent(String.self, forKey: .passport_issuing_country)
		passport_expiry_date = try values.decodeIfPresent(String.self, forKey: .passport_expiry_date)
		ff_no = try values.decodeIfPresent(String.self, forKey: .ff_no)
		ticket_no = try values.decodeIfPresent(String.self, forKey: .ticket_no)
		oneway_bag = try values.decodeIfPresent(String.self, forKey: .oneway_bag)
		return_bag = try values.decodeIfPresent(String.self, forKey: .return_bag)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		attributes = try values.decodeIfPresent(String.self, forKey: .attributes)
		mailing_status = try values.decodeIfPresent(String.self, forKey: .mailing_status)
	}

}
