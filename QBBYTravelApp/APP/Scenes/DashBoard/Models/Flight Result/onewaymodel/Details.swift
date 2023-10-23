

import Foundation
struct Details : Codable {
	let weight_Allowance : String?
	let flight_number : String?
	let display_operator_code : String?
	let no_of_stops : Int?
	let cabin_class : String?
	let duration_seconds : Int?
	let meal_description : String?
	let seatsRemaining : String?
	let operator_code : String?
	let origin : Origin?
	let destination : Destination?
	let operator_name : String?
	let duration : String?
	let dclass : Class?
	let meal : String?
	let operator_image : String?

	enum CodingKeys: String, CodingKey {

		case weight_Allowance = "Weight_Allowance"
		case flight_number = "flight_number"
		case display_operator_code = "display_operator_code"
		case no_of_stops = "no_of_stops"
		case cabin_class = "cabin_class"
		case duration_seconds = "duration_seconds"
		case meal_description = "Meal_description"
		case seatsRemaining = "SeatsRemaining"
		case operator_code = "operator_code"
		case origin = "origin"
		case destination = "destination"
		case operator_name = "operator_name"
		case duration = "duration"
		case dclass = "class"
		case meal = "Meal"
		case operator_image = "operator_image"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		weight_Allowance = try values.decodeIfPresent(String.self, forKey: .weight_Allowance)
		flight_number = try values.decodeIfPresent(String.self, forKey: .flight_number)
		display_operator_code = try values.decodeIfPresent(String.self, forKey: .display_operator_code)
		no_of_stops = try values.decodeIfPresent(Int.self, forKey: .no_of_stops)
		cabin_class = try values.decodeIfPresent(String.self, forKey: .cabin_class)
		duration_seconds = try values.decodeIfPresent(Int.self, forKey: .duration_seconds)
		meal_description = try values.decodeIfPresent(String.self, forKey: .meal_description)
		seatsRemaining = try values.decodeIfPresent(String.self, forKey: .seatsRemaining)
		operator_code = try values.decodeIfPresent(String.self, forKey: .operator_code)
		origin = try values.decodeIfPresent(Origin.self, forKey: .origin)
		destination = try values.decodeIfPresent(Destination.self, forKey: .destination)
		operator_name = try values.decodeIfPresent(String.self, forKey: .operator_name)
		duration = try values.decodeIfPresent(String.self, forKey: .duration)
		dclass = try values.decodeIfPresent(Class.self, forKey: .dclass)
		meal = try values.decodeIfPresent(String.self, forKey: .meal)
		operator_image = try values.decodeIfPresent(String.self, forKey: .operator_image)
	}

}
