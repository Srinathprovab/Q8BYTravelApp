

import Foundation
struct Booking_transaction_details : Codable {
	let origin : String?
	let app_reference : String?
	let tF_booking_reference : String?
	let supplier_reference : String?
	let source : String?
	let airline : String?
	let pnr : String?
	let airline_pnr : String?
	let suppliercode : String?
	let providerlocatorcode : String?
	let invoice_number : String?
	let provab_invoice_number : String?
	let status : String?
	let status_description : String?
	let book_id : String?
	let booking_source : String?
	let ref_id : String?
	let is_dom : String?
	let total_fare : String?
	let admin_commission : String?
	let dist_commission : String?
	let agent_commission : String?
	let admin_tds_on_commission : String?
	let dist_tds_on_commission : String?
	let agent_tds_on_commission : String?
	let admin_markup : String?
	let dist_markup : String?
	let agent_markup : String?
	let handling_charge : String?
	let service_tax : String?
	let convinence_amount : String?
	let currency : String?
	let fare_attributes : String?
	let flight_fare_attributes : String?
	let getbooking_StatusCode : String?
	let getbooking_Description : String?
	let getbooking_Category : String?
	let attributes : String?
	let api_attributes : String?
	let sequence_number : String?
	let api_total_fare : String?
	let payment_status : String?
	let customer_payment_details : String?
	let seat_data_req : String?
	let seat_data : String?
	let seat_cost : String?
	let intial_cancellation_data : String?
	let final_cancellation_data : String?
	let final_cancellation_made_by : String?
	let invoice_status : String?
	let booking_customer_details : [Booking_customer_details]?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case app_reference = "app_reference"
		case tF_booking_reference = "TF_booking_reference"
		case supplier_reference = "supplier_reference"
		case source = "source"
		case airline = "airline"
		case pnr = "pnr"
		case airline_pnr = "airline_pnr"
		case suppliercode = "suppliercode"
		case providerlocatorcode = "providerlocatorcode"
		case invoice_number = "invoice_number"
		case provab_invoice_number = "provab_invoice_number"
		case status = "status"
		case status_description = "status_description"
		case book_id = "book_id"
		case booking_source = "booking_source"
		case ref_id = "ref_id"
		case is_dom = "is_dom"
		case total_fare = "total_fare"
		case admin_commission = "admin_commission"
		case dist_commission = "dist_commission"
		case agent_commission = "agent_commission"
		case admin_tds_on_commission = "admin_tds_on_commission"
		case dist_tds_on_commission = "dist_tds_on_commission"
		case agent_tds_on_commission = "agent_tds_on_commission"
		case admin_markup = "admin_markup"
		case dist_markup = "dist_markup"
		case agent_markup = "agent_markup"
		case handling_charge = "handling_charge"
		case service_tax = "service_tax"
		case convinence_amount = "convinence_amount"
		case currency = "currency"
		case fare_attributes = "fare_attributes"
		case flight_fare_attributes = "flight_fare_attributes"
		case getbooking_StatusCode = "getbooking_StatusCode"
		case getbooking_Description = "getbooking_Description"
		case getbooking_Category = "getbooking_Category"
		case attributes = "attributes"
		case api_attributes = "api_attributes"
		case sequence_number = "sequence_number"
		case api_total_fare = "api_total_fare"
		case payment_status = "payment_status"
		case customer_payment_details = "customer_payment_details"
		case seat_data_req = "seat_data_req"
		case seat_data = "seat_data"
		case seat_cost = "seat_cost"
		case intial_cancellation_data = "intial_cancellation_data"
		case final_cancellation_data = "final_cancellation_data"
		case final_cancellation_made_by = "final_cancellation_made_by"
		case invoice_status = "invoice_status"
		case booking_customer_details = "booking_customer_details"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
		tF_booking_reference = try values.decodeIfPresent(String.self, forKey: .tF_booking_reference)
		supplier_reference = try values.decodeIfPresent(String.self, forKey: .supplier_reference)
		source = try values.decodeIfPresent(String.self, forKey: .source)
		airline = try values.decodeIfPresent(String.self, forKey: .airline)
		pnr = try values.decodeIfPresent(String.self, forKey: .pnr)
		airline_pnr = try values.decodeIfPresent(String.self, forKey: .airline_pnr)
		suppliercode = try values.decodeIfPresent(String.self, forKey: .suppliercode)
		providerlocatorcode = try values.decodeIfPresent(String.self, forKey: .providerlocatorcode)
		invoice_number = try values.decodeIfPresent(String.self, forKey: .invoice_number)
		provab_invoice_number = try values.decodeIfPresent(String.self, forKey: .provab_invoice_number)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		status_description = try values.decodeIfPresent(String.self, forKey: .status_description)
		book_id = try values.decodeIfPresent(String.self, forKey: .book_id)
		booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
		ref_id = try values.decodeIfPresent(String.self, forKey: .ref_id)
		is_dom = try values.decodeIfPresent(String.self, forKey: .is_dom)
		total_fare = try values.decodeIfPresent(String.self, forKey: .total_fare)
		admin_commission = try values.decodeIfPresent(String.self, forKey: .admin_commission)
		dist_commission = try values.decodeIfPresent(String.self, forKey: .dist_commission)
		agent_commission = try values.decodeIfPresent(String.self, forKey: .agent_commission)
		admin_tds_on_commission = try values.decodeIfPresent(String.self, forKey: .admin_tds_on_commission)
		dist_tds_on_commission = try values.decodeIfPresent(String.self, forKey: .dist_tds_on_commission)
		agent_tds_on_commission = try values.decodeIfPresent(String.self, forKey: .agent_tds_on_commission)
		admin_markup = try values.decodeIfPresent(String.self, forKey: .admin_markup)
		dist_markup = try values.decodeIfPresent(String.self, forKey: .dist_markup)
		agent_markup = try values.decodeIfPresent(String.self, forKey: .agent_markup)
		handling_charge = try values.decodeIfPresent(String.self, forKey: .handling_charge)
		service_tax = try values.decodeIfPresent(String.self, forKey: .service_tax)
		convinence_amount = try values.decodeIfPresent(String.self, forKey: .convinence_amount)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		fare_attributes = try values.decodeIfPresent(String.self, forKey: .fare_attributes)
		flight_fare_attributes = try values.decodeIfPresent(String.self, forKey: .flight_fare_attributes)
		getbooking_StatusCode = try values.decodeIfPresent(String.self, forKey: .getbooking_StatusCode)
		getbooking_Description = try values.decodeIfPresent(String.self, forKey: .getbooking_Description)
		getbooking_Category = try values.decodeIfPresent(String.self, forKey: .getbooking_Category)
		attributes = try values.decodeIfPresent(String.self, forKey: .attributes)
		api_attributes = try values.decodeIfPresent(String.self, forKey: .api_attributes)
		sequence_number = try values.decodeIfPresent(String.self, forKey: .sequence_number)
		api_total_fare = try values.decodeIfPresent(String.self, forKey: .api_total_fare)
		payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
		customer_payment_details = try values.decodeIfPresent(String.self, forKey: .customer_payment_details)
		seat_data_req = try values.decodeIfPresent(String.self, forKey: .seat_data_req)
		seat_data = try values.decodeIfPresent(String.self, forKey: .seat_data)
		seat_cost = try values.decodeIfPresent(String.self, forKey: .seat_cost)
		intial_cancellation_data = try values.decodeIfPresent(String.self, forKey: .intial_cancellation_data)
		final_cancellation_data = try values.decodeIfPresent(String.self, forKey: .final_cancellation_data)
		final_cancellation_made_by = try values.decodeIfPresent(String.self, forKey: .final_cancellation_made_by)
		invoice_status = try values.decodeIfPresent(String.self, forKey: .invoice_status)
		booking_customer_details = try values.decodeIfPresent([Booking_customer_details].self, forKey: .booking_customer_details)
	}

}
