//
//  Constants.swift
//  DoorcastRebase
//
//  Created by U Dinesh Kumar Reddy on 04/05/22.
//

import Foundation
import UIKit
import CoreData
/*SETTING USER DEFAULTS*/
let defaults = UserDefaults.standard

let loginResponseDefaultKey = "LoginResponse"
let KPlatform = "Platform"
let KPlatformValue = "iOS"
let KContentType = "Content-Type"
let KContentTypeValue = "application/x-www-form-urlencoded"
let KAccept = "Accept"
let KAcceptValue = "application/json"
let KAuthorization = "Authorization"
//let KDEVICE_ID = "DEVICE_ID"
let KAccesstoken = "Accesstoken"
let KAccesstokenValue = ""
var key = ""
let screenHeight = UIScreen.main.bounds.size.height
//var data : Data?

//MARK: - Base url
var BASE_URL = "https://q8by.com/mobile_webservices/index.php/"
var BASE_URL1 = "https://q8by.com/mobile_webservices/index.php/"

var countrylist = [Country_list]()

//MARK: - COREDATE SAVE PASSENGER DETAILS
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

var meallist = [Meal]()
var specialAssistancelist1 = [Meal]()

//MARK: - Profile
var profildata:ProfileUpdateData?
var callapibool = Bool()


//MARK: - Filters
var filterModel = FlightFilterModel()
var hotelfiltermodel = HotelFilterModel()
var sortBy: SortParameter = .nothing
var starRatingFilter = String()


//MARK: - Homepage
var besttopflightArray = [Flight_top_destinations1]()
var besttopHotelArray = [Flight_top_destinations1]()
var perfectholidaysArray = [Perfect_holidays]()
var imgPath = String()
var mobilenoMaxLengthBool = Bool()
var countrycode = String()

var searchid = String()
var bookingsource = String()
var bookingsourcekey = String()
var accesskey = String()

var oneWayFlights = [[J_flight_list]]()
var roundTripFlights = [[J_flight_list]]()
var multicityTripFlights = [[MJ_flight_list]]()

//MARK: -Flight Detais
var search_id = String()
var booking_source = String()
var fareRulesData = [FareRulehtml]()
var fd = [[FlightDetails]]()
var ageCategory: AgeCategory = .adult



//MARK: - Multicity
var fromCityCodeArray = ["Origen","Origen"]
var fromlocidArray = ["",""]
var toCitycodeArray = ["Destination","Destination"]
var tolocidArray = ["",""]
var depatureDatesArray = ["Date","Date"]
var fromCityNameArray = ["",""]
var toCityNameArray = ["",""]

//HOTEL
var adtArray = [String]()
var chArray = [String]()
var hbooking_source = String()
var hsearch_id = String()
var hotelid = String()
var ratekeyArray = [String]()
var htoken = String()
var htokenkey = String()
var hotelDetalsinfo:Hotel_details?
var hotelImages = [Images]()
var hotelimg = String()
var hbookingToken = String()




//MARK: - FILTERS
var prices = [String]()
var noofStopsA = [String]()
var fareTypeA = [String]()
var airlinesA = [String]()
var cancellationsTypeA = [String]()
var connectingFlightsA = [String]()
var connectingAirportA = [String]()
var departureTimeA = [String]()
var arrivalTimeA = [String]()


//Price Syummery
var AdultsTotalPrice = String()
var ChildTotalPrice = String()
var InfantTotalPrice = String()
var sub_total_adult : String?
var sub_total_child : String?
var sub_total_infant : String?

var Adults_Base_Price = String()
var Adults_Tax_Price = String()
var Childs_Base_Price = String()
var Childs_Tax_Price = String()
var Infants_Base_Price = String()
var Infants_Tax_Price = String()
var TotalPrice_API = String()
var grandTotal = String()
var subtotal = String()


//MARK: - Travellers Details

var checkOptionCountArray = [String]()
var passengertypeArray = [String]()
var genderArray = [String]()
var leadPassengerArray = [String]()
var middleNameArray = [String]()
var arrayOf_SelectedCellsAdult = [IndexPath]()
var arrayOf_SelectedCellsChild = [IndexPath]()
var arrayOf_SelectedCellsInfanta = [IndexPath]()
var totalNoOfTravellers = String()
var passengerA = [Passenger]()
var travellerdetails  = [NSFetchRequestResult]()



//PaymentVC
var travelerArray: [Traveler] = []


//Booking confirmed
var bookedDate = String()
var bookingRefrence = String()
var checkTermsAndCondationStatus = false

//Hotels
var facilityArray = [String]()
var faretypeArray = [String]()
var neighbourwoodArray = [String]()
var amenitiesArray = [String]()
var nearBylocationsArray = [String]()
var totalRooms = 0
var isfilterApplied = false
var mapModelArray: [MapModel] = []


/* URL endpoints */
struct ApiEndpoints {
    static let countrylist1 = "general/getCountrylist"
    static let mobilePreFlightSearch = "mobile_pre_flight_search"
    static let general_getAirlineList = "general/getAirlineList"
    static let mobilelogin = "mobile_login"
    static let mobilelogout = "mobile_logout"
    static let mobileregister = "auth/mobile_register_on_light_box"
    static let mobileforgotpassword = "mobile_forgot_password"
    static let updatemobileprofile = "user/mobile_profile"
    static let getCurrencyList = "general/getCurrencyList"
    static let mobilepreflightsearch = "general/mobile_pre_flight_search"
    static let getFlightDetails = "flight/getFlightDetails"
    static let preflightsearchmobile = "pre_flight_search_mobile"
    static let getairportcodelist = "ajax/get_airport_code_list"
    static let gethomePage = "general/index"
    static let preprocessbooking = "flight/pre_process_booking"
    static let flightbooking = "flight/booking"
    static let processpassengerdetail = "flight/process_passenger_detail/"
    static let prebooking = "flight/pre_booking/"
    static let prepaymentconfirmation = "flight/pre_payment_confirmation/"
    static let sendtopayment = "flight/send_to_payment/"
    static let securebooking = "flight/secure_booking/"
    static let getCountrylist = "general/getCountrylist"
    
    static let upcomingbookingmobile = "flight/upcoming_booking_mobile"
    static let completedbookingmobile = "flight/completed_booking_mobile"
    static let cancelledbookingmobile = "flight/cancelled_booking_mobile"
    static let getSpecialAssistancelist = "general/getSpecialAssistance_list"
    static let getMeals_list = "general/getMeals_list"
    
    
    //HOTEL
    static let hotel_getActiveBookingSource = "general/getActiveBookingSource"
    static let mobileprehotelsearch = "general/mobile_pre_hotel_search"
    static let gethotelcitylist = "ajax/get_hotel_city_list"
    static let hoteldetails = "hotel/mobile_details"
    static let hotelmobilebooking = "hotel/mobile_booking"
    static let mobilehotelprebooking = "hotel/mobile_hotel_pre_booking"
    static let hotelsecurebooking = "hotel/secure_booking"
    
    
    
    //HOLIDAY
    static let getholidaytcitylist = "ajax/get_tour_city_package_list"
    static let preholidaysearch = "tours/pre_holiday_search"
    static let toursdetails = "tours/details"
    
}

/*App messages*/
struct Message {
    static let internetConnectionError = "Please check your connection and try reconnecting to internet"
    static let sessionExpired = "Your session has been expired, please login again"
}


/*USER ENTERED DETAILS DEFAULTS*/

struct UserDefaultsKeys {
    
    static var tabselect = "tabselect"
    static var userLoggedIn = "userLoggedIn"
    static var loggedInStatus = "loggedInStatus"
    static var userid = "userid"
    static var username = "username"
    static var userimg = "userimg"
    static var journeyType = "Journey_Type"
    static var selectedCurrency = "selectedCurrency"
    static var itinerarySelectedIndex = "ItinerarySelectedIndex"
    static var select_classIndex = "select_classIndex"
    static var rselect_classIndex = "rselect_classIndex"
    static var mselect_classIndex = "mselect_classIndex"
    static var totalTravellerCount = "totalTravellerCount"
    static var cellTag = "cellTag"
    static var nationality = "nationality"
    static var airlinescode = "airlinescode"
    static var hnationality = "hnationality"
    static var hnationalitycode = "hnationalitycode"
    
    
    
    
    
    //ONE WAY
    static var fromCity = "fromCity"
    static var toCity = "toCity"
    static var calDepDate = "calDepDate"
    static var calRetDate = "calRetDate"
    static var adultCount = "Adult_Count"
    static var childCount = "Child_Count"
    static var hadultCount = "HAdult_Count"
    static var hchildCount = "HChild_Count"
    static var infantsCount = "Infants_Count"
    static var selectClass = "select_class"
    static var fromlocid = "from_loc_id"
    static var tolocid = "to_loc_id"
    static var fromcityname = "fromcityname"
    static var tocityname = "tocityname"
    
    
    //ROUND TRIP
    static var rlocationcity = "rlocation_city"
    static var rfromCity = "rfromCity"
    static var rtoCity = "rtoCity"
    static var rcalDepDate = "rcalDepDate"
    static var rcalRetDate = "rcalRetDate"
    static var radultCount = "rAdult_Count"
    static var rchildCount = "rChild_Count"
    static var rhadultCount = "rHAdult_Count"
    static var rhchildCount = "rHChild_Count"
    static var rinfantsCount = "rInfants_Count"
    static var rselectClass = "rselect_class"
    static var rfromlocid = "rfrom_loc_id"
    static var rtolocid = "rto_loc_id"
    static var rfromcityname = "rfromcityname"
    static var rtocityname = "rtocityname"
    
    
    
    //MULTICITY TRIP
    static var mlocationcity = "mlocation_city"
    static var mfromCity = "mfromCity"
    static var mtoCity = "mtoCity"
    static var mcalDepDate = "mcalDepDate"
    static var mcalRetDate = "mcalRetDate"
    static var madultCount = "mAdult_Count"
    static var mchildCount = "mChild_Count"
    static var mhadultCount = "mHAdult_Count"
    static var mhchildCount = "mHChild_Count"
    static var minfantsCount = "mInfants_Count"
    static var mselectClass = "mselect_class"
    static var mfromlocid = "mfrom_loc_id"
    static var mtolocid = "mto_loc_id"
    static var mfromcityname = "mfromcityname"
    static var mtocityname = "mtocityname"
    
    
    //Hotel
    static var locationcity = "location_city"
    static var locationid = "location_id"
    static var hoteladultCount = "HotelAdult_Count"
    static var hotelchildCount = "HotelChild_Count"
    static var cityid = "cityid"
    static var htravellerDetails = "htraveller_Details"
    static var roomType = "Room_Type"
    static var refundtype = "refundtype"
    static var rateKey = "rateKey"
    static var select = "select"
    static var checkin = "check_in"
    static var checkout = "check _out"
    static var addTarvellerDetails = "addTarvellerDetails"
    static var rtravellerDetails = "rtraveller_Details"
    static var mtravellerDetails = "mtraveller_Details"
    static var travellerDetails = "traveller_Details"
    static var journyCitys = "journyCitys"
    static var journyDates = "journyDates"
    static var roomcount = "room_count"
    static var hoteladultscount = "hotel_adults_count"
    static var hotelchildcount = "hotel_child_count"
    static var guestcount = "guestcount"
    static var selectPersons = "selectPersons"
    static var kwdprice = "kwdprice"
    
    
    //Holiday
    static var holidaylocationcity = "holidaylocation_city"
    static var holidaylocationid = "holidaylocation_id"
    
}


struct sessionMgrDefaults {
    
    static var userLoggedIn = "username"
    static var loggedInStatus = "email"
    static var globalAT = "mobile_no"
    static var Base_url = "accesstoken"
}



/*LOCAL JSON FILES*/
struct LocalJsonFiles {
    
}
