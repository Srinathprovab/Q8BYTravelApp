
import Foundation
struct Res_data : Codable {
	let origin : String?
	let xlprofld : String?
	let domain_origin : String?
	let app_reference : String?
	let app_reference_gds : String?
	let booking_source : String?
	let trip_type : String?
	let is_lcc : String?
	let phone : String?
	let alternate_number : String?
	let email : String?
	let journey_start : String?
	let journey_end : String?
	let journey_from : String?
	let journey_to : String?
	let from_loc : String?
	let to_loc : String?
	let payment_mode : String?
	let convinence_value : String?
	let convinence_value_type : String?
	let convinence_per_pax : String?
	let convinence_amount : String?
	let discount : String?
	let total_price_attributes : String?
	let attributes : String?
	let seat_information : String?
	let seat_price : String?
	let booking_billing_type : String?
	let booked_by_id : String?
	let created_by_id : String?
	let block_user_id : String?
	let created_datetime : String?
	let seat_booking_status : String?
	let meal_booking_status : String?
	let seat_booking_error : String?
	let meal_booking_error : String?
	let ff_status : String?
	let ff_error_message : String?
	let status : String?
	let insurance_covered : String?
	let reward_amount : String?
	let reward_points : String?
	let reward_earned : String?
	let booking_status : String?
	let total_fare : String?
	let currency : String?
	let uRL : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case xlprofld = "xlprofld"
		case domain_origin = "domain_origin"
		case app_reference = "app_reference"
		case app_reference_gds = "app_reference_gds"
		case booking_source = "booking_source"
		case trip_type = "trip_type"
		case is_lcc = "is_lcc"
		case phone = "phone"
		case alternate_number = "alternate_number"
		case email = "email"
		case journey_start = "journey_start"
		case journey_end = "journey_end"
		case journey_from = "journey_from"
		case journey_to = "journey_to"
		case from_loc = "from_loc"
		case to_loc = "to_loc"
		case payment_mode = "payment_mode"
		case convinence_value = "convinence_value"
		case convinence_value_type = "convinence_value_type"
		case convinence_per_pax = "convinence_per_pax"
		case convinence_amount = "convinence_amount"
		case discount = "discount"
		case total_price_attributes = "total_price_attributes"
		case attributes = "attributes"
		case seat_information = "seat_information"
		case seat_price = "seat_price"
		case booking_billing_type = "booking_billing_type"
		case booked_by_id = "booked_by_id"
		case created_by_id = "created_by_id"
		case block_user_id = "block_user_id"
		case created_datetime = "created_datetime"
		case seat_booking_status = "seat_booking_status"
		case meal_booking_status = "meal_booking_status"
		case seat_booking_error = "seat_booking_error"
		case meal_booking_error = "meal_booking_error"
		case ff_status = "ff_status"
		case ff_error_message = "ff_error_message"
		case status = "status"
		case insurance_covered = "insurance_covered"
		case reward_amount = "reward_amount"
		case reward_points = "reward_points"
		case reward_earned = "reward_earned"
		case booking_status = "booking_status"
		case total_fare = "total_fare"
		case currency = "currency"
		case uRL = "URL"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		xlprofld = try values.decodeIfPresent(String.self, forKey: .xlprofld)
		domain_origin = try values.decodeIfPresent(String.self, forKey: .domain_origin)
		app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
		app_reference_gds = try values.decodeIfPresent(String.self, forKey: .app_reference_gds)
		booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
		trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
		is_lcc = try values.decodeIfPresent(String.self, forKey: .is_lcc)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		alternate_number = try values.decodeIfPresent(String.self, forKey: .alternate_number)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		journey_start = try values.decodeIfPresent(String.self, forKey: .journey_start)
		journey_end = try values.decodeIfPresent(String.self, forKey: .journey_end)
		journey_from = try values.decodeIfPresent(String.self, forKey: .journey_from)
		journey_to = try values.decodeIfPresent(String.self, forKey: .journey_to)
		from_loc = try values.decodeIfPresent(String.self, forKey: .from_loc)
		to_loc = try values.decodeIfPresent(String.self, forKey: .to_loc)
		payment_mode = try values.decodeIfPresent(String.self, forKey: .payment_mode)
		convinence_value = try values.decodeIfPresent(String.self, forKey: .convinence_value)
		convinence_value_type = try values.decodeIfPresent(String.self, forKey: .convinence_value_type)
		convinence_per_pax = try values.decodeIfPresent(String.self, forKey: .convinence_per_pax)
		convinence_amount = try values.decodeIfPresent(String.self, forKey: .convinence_amount)
		discount = try values.decodeIfPresent(String.self, forKey: .discount)
		total_price_attributes = try values.decodeIfPresent(String.self, forKey: .total_price_attributes)
		attributes = try values.decodeIfPresent(String.self, forKey: .attributes)
		seat_information = try values.decodeIfPresent(String.self, forKey: .seat_information)
		seat_price = try values.decodeIfPresent(String.self, forKey: .seat_price)
		booking_billing_type = try values.decodeIfPresent(String.self, forKey: .booking_billing_type)
		booked_by_id = try values.decodeIfPresent(String.self, forKey: .booked_by_id)
		created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
		block_user_id = try values.decodeIfPresent(String.self, forKey: .block_user_id)
		created_datetime = try values.decodeIfPresent(String.self, forKey: .created_datetime)
		seat_booking_status = try values.decodeIfPresent(String.self, forKey: .seat_booking_status)
		meal_booking_status = try values.decodeIfPresent(String.self, forKey: .meal_booking_status)
		seat_booking_error = try values.decodeIfPresent(String.self, forKey: .seat_booking_error)
		meal_booking_error = try values.decodeIfPresent(String.self, forKey: .meal_booking_error)
		ff_status = try values.decodeIfPresent(String.self, forKey: .ff_status)
		ff_error_message = try values.decodeIfPresent(String.self, forKey: .ff_error_message)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		insurance_covered = try values.decodeIfPresent(String.self, forKey: .insurance_covered)
		reward_amount = try values.decodeIfPresent(String.self, forKey: .reward_amount)
		reward_points = try values.decodeIfPresent(String.self, forKey: .reward_points)
		reward_earned = try values.decodeIfPresent(String.self, forKey: .reward_earned)
		booking_status = try values.decodeIfPresent(String.self, forKey: .booking_status)
		total_fare = try values.decodeIfPresent(String.self, forKey: .total_fare)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		uRL = try values.decodeIfPresent(String.self, forKey: .uRL)
	}

}
