
import Foundation
struct Booking_itinerary_details : Codable {
	let origin : String?
	let booking_source : String?
	let flight_booking_transaction_details_fk : String?
	let app_reference : String?
	let airline_pnr : String?
	let departure_index : String?
	let is_leg : String?
	let segment_indicator : String?
	let airline_code : String?
	let airline_name : String?
	let flight_number : String?
	let fare_class : String?
	let from_airport_code : String?
	let from_airport_name : String?
	let to_airport_code : String?
	let to_airport_name : String?
	let departure_datetime : String?
	let old_departure_datetime : String?
	let arrival_datetime : String?
	let origin_terminal : String?
	let destination_terminal : String?
	let cabin_class : String?
	let resBookDesigCode : String?
	let status : String?
	let operating_carrier : String?
	let fareRestriction : String?
	let fareBasisCode : String?
	let fareRuleDetail : String?
	let attributes : String?
	let is_layover : String?
	let layover : String?
	let schedulechange : String?
	let schedulechange_email : String?
	let checklistmail : String?
	let send_pre_mail : String?
	let thankyoumail : String?
	let email_eticket_invoice : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case booking_source = "booking_source"
		case flight_booking_transaction_details_fk = "flight_booking_transaction_details_fk"
		case app_reference = "app_reference"
		case airline_pnr = "airline_pnr"
		case departure_index = "departure_index"
		case is_leg = "is_leg"
		case segment_indicator = "segment_indicator"
		case airline_code = "airline_code"
		case airline_name = "airline_name"
		case flight_number = "flight_number"
		case fare_class = "fare_class"
		case from_airport_code = "from_airport_code"
		case from_airport_name = "from_airport_name"
		case to_airport_code = "to_airport_code"
		case to_airport_name = "to_airport_name"
		case departure_datetime = "departure_datetime"
		case old_departure_datetime = "old_departure_datetime"
		case arrival_datetime = "arrival_datetime"
		case origin_terminal = "origin_terminal"
		case destination_terminal = "destination_terminal"
		case cabin_class = "cabin_class"
		case resBookDesigCode = "ResBookDesigCode"
		case status = "status"
		case operating_carrier = "operating_carrier"
		case fareRestriction = "FareRestriction"
		case fareBasisCode = "FareBasisCode"
		case fareRuleDetail = "FareRuleDetail"
		case attributes = "attributes"
		case is_layover = "is_layover"
		case layover = "layover"
		case schedulechange = "schedulechange"
		case schedulechange_email = "schedulechange_email"
		case checklistmail = "checklistmail"
		case send_pre_mail = "send_pre_mail"
		case thankyoumail = "thankyoumail"
		case email_eticket_invoice = "email_eticket_invoice"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
		flight_booking_transaction_details_fk = try values.decodeIfPresent(String.self, forKey: .flight_booking_transaction_details_fk)
		app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
		airline_pnr = try values.decodeIfPresent(String.self, forKey: .airline_pnr)
		departure_index = try values.decodeIfPresent(String.self, forKey: .departure_index)
		is_leg = try values.decodeIfPresent(String.self, forKey: .is_leg)
		segment_indicator = try values.decodeIfPresent(String.self, forKey: .segment_indicator)
		airline_code = try values.decodeIfPresent(String.self, forKey: .airline_code)
		airline_name = try values.decodeIfPresent(String.self, forKey: .airline_name)
		flight_number = try values.decodeIfPresent(String.self, forKey: .flight_number)
		fare_class = try values.decodeIfPresent(String.self, forKey: .fare_class)
		from_airport_code = try values.decodeIfPresent(String.self, forKey: .from_airport_code)
		from_airport_name = try values.decodeIfPresent(String.self, forKey: .from_airport_name)
		to_airport_code = try values.decodeIfPresent(String.self, forKey: .to_airport_code)
		to_airport_name = try values.decodeIfPresent(String.self, forKey: .to_airport_name)
		departure_datetime = try values.decodeIfPresent(String.self, forKey: .departure_datetime)
		old_departure_datetime = try values.decodeIfPresent(String.self, forKey: .old_departure_datetime)
		arrival_datetime = try values.decodeIfPresent(String.self, forKey: .arrival_datetime)
		origin_terminal = try values.decodeIfPresent(String.self, forKey: .origin_terminal)
		destination_terminal = try values.decodeIfPresent(String.self, forKey: .destination_terminal)
		cabin_class = try values.decodeIfPresent(String.self, forKey: .cabin_class)
		resBookDesigCode = try values.decodeIfPresent(String.self, forKey: .resBookDesigCode)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		operating_carrier = try values.decodeIfPresent(String.self, forKey: .operating_carrier)
		fareRestriction = try values.decodeIfPresent(String.self, forKey: .fareRestriction)
		fareBasisCode = try values.decodeIfPresent(String.self, forKey: .fareBasisCode)
		fareRuleDetail = try values.decodeIfPresent(String.self, forKey: .fareRuleDetail)
		attributes = try values.decodeIfPresent(String.self, forKey: .attributes)
		is_layover = try values.decodeIfPresent(String.self, forKey: .is_layover)
		layover = try values.decodeIfPresent(String.self, forKey: .layover)
		schedulechange = try values.decodeIfPresent(String.self, forKey: .schedulechange)
		schedulechange_email = try values.decodeIfPresent(String.self, forKey: .schedulechange_email)
		checklistmail = try values.decodeIfPresent(String.self, forKey: .checklistmail)
		send_pre_mail = try values.decodeIfPresent(String.self, forKey: .send_pre_mail)
		thankyoumail = try values.decodeIfPresent(String.self, forKey: .thankyoumail)
		email_eticket_invoice = try values.decodeIfPresent(String.self, forKey: .email_eticket_invoice)
	}

}
