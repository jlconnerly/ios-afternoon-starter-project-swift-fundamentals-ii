import UIKit


//: ## 1. Create custom types to represent an Airport Departures display
//: ![Airport Departures](matthew-smith-5934-unsplash.jpg)
//: Look at data from [Departures at JFK Airport in NYC](https://www.airport-jfk.com/departures.php) for reference.
//:
//: a. Use an `enum` type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)
//:
//: b. Use a struct to represent an `Airport` (Destination or Arrival)
//:
//: c. Use a struct to represent a `Flight`.
//:
//: d. Use a `Date?` for the departure time since it may be canceled.
//:
//: e. Use a `String?` for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)
//:
//: f. Use a class to represent a `DepartureBoard` with a list of departure flights, and the current airport
enum FlightStatus {
    case enRoute
    case sheduled
    case canceled
    case delayed
    case landed
    case boarding
}

struct Airport {
    var name: String
    var city: String
    var abbriviation: String
}

struct Flight {
    var airline: String
    var flightNumber: String
    var departureTime: Date?
    var terminal: String?
    var status: FlightStatus
    var destination: Airport
    
}

let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .none
dateFormatter.timeStyle = .short

class DepartureBoard {
    var board: [Flight]
    var currentCity: Airport
    
    init(currentCity: Airport) {
        self.currentCity = currentCity
        board = []
    }
    
    func flightAlert() {
        for flight in board {
            var departureStr = "TBD"
            if let departureTime = flight.departureTime {
                departureStr = dateFormatter.string(from: departureTime)
            }
            var terminalStr = "TBD"
            if let terminal = flight.terminal {
                terminalStr = terminal
            }
            switch flight.status {
            case .canceled:
                print("We're sorry your flight to \(flight.destination.city) was canceled, here is a $500 voucher.")
            case .sheduled:
                print("Your flight to \(flight.destination.city) is scheduled to depart at \(departureStr) from terminal: \(terminalStr)")
            case .boarding:
                print("Your flight is boarding, please head to terminal: \(terminalStr) immediately. The doors are closing soon.")
            case .delayed:
                print("your flight \(flight.flightNumber) to \(flight.destination.city) has been delayed.")
            case .enRoute:
                print("your flight \(flight.flightNumber) to \(flight.destination.city) is on its way!")
            case .landed:
                print("The \(flight.airline) flight number \(flight.flightNumber) has landed.")
            }
            if flight.terminal == nil {
                print("Passengers on \(flight.airline) flight \(flight.flightNumber) towards \(flight.destination.name), your terminal is currently unavailable. Please  see the nearest information desk for more details.")
            }
        }
    }
}

//a. If the flight is canceled print out: "We're sorry your flight to (city) was canceled, here is a $500 voucher"
//
//b. If the flight is scheduled print out: "Your flight to (city) is scheduled to depart at (time) from terminal: (terminal)"
//
//c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: (terminal) immediately. The doors are closing soon."
//
//d. If the departureTime or terminal are optional, use "TBD" instead of a blank String
//
//e. If you have any other cases to handle please print out appropriate messages
//
//d. Call the alertPassengers() function on your DepartureBoard object below
//
//f. Stretch: Display a custom message if the terminal is nil, tell the traveler to see the nearest information desk for more details.
//: ## 2. Create 3 flights and add them to a departure board
//: a. For the departure time, use `Date()` for the current time
//:
//: b. Use the Array `append()` method to add `Flight`'s
//:
//: c. Make one of the flights `.canceled` with a `nil` departure time
//:
//: d. Make one of the flights have a `nil` terminal because it has not been decided yet.
//:
//: e. Stretch: Look at the API for [`DateComponents`](https://developer.apple.com/documentation/foundation/datecomponents?language=objc) for creating a specific time
let jfk = Airport(name: "John F. Kennedy International Airport", city: "Queens, NY", abbriviation: "JFK")

let flightOne = Flight(airline: "Southwest", flightNumber: "P2034", departureTime: Date(), terminal: nil, status: .enRoute, destination: Airport(name: "Dallas Love Field", city: "Dallas, TX", abbriviation: "DAL"))
let flightTwo = Flight(airline: "Continental Airlines", flightNumber: "F2234", departureTime: Date(), terminal: "F34", status: .landed, destination: Airport(name: "Juneau International Airport", city: "Juneau, AK", abbriviation: "JNU"))
let flightThree = Flight(airline: "American Airlines", flightNumber: "AA353", departureTime: nil, terminal: "D38", status: .canceled, destination: Airport(name: "Licenciado Gustavo Díaz Ordaz International Airport", city: "Puerto Vallarta, Jal., Mexico", abbriviation: "PVR"))

let jfkDepartureBoard = DepartureBoard(currentCity: jfk)

jfkDepartureBoard.board.append(contentsOf: [flightOne, flightTwo, flightThree])
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
/*
func printDepartures(departureBoard: DepartureBoard) {
    for flight in departureBoard.board {
        if flight.departureTime == nil {
            print("Airline: \(flight.airline) Destiniation: \(flight.destination.city) Departure Time: N/A Terminal: \(flight.terminal) STATUS: CANCELLED.")
        }else if flight.terminal == nil {
            print("Airline: \(flight.airline) Destiniation: \(flight.destination.city) Departure Time: \(flight.departureTime) Terminal: TBD STATUS: \(flight.status)")
        }else {
        print("Airline: \(flight.airline) Destiniation: \(flight.destination.city) Departure Time: \(flight.departureTime) Terminal:\(flight.terminal) STATUS: \(flight.status)")
        }
    }
}

printDepartures(departureBoard: jfkDepartureBoard)
*/
//: ## 4. Make a second function to print print an empty string if the `departureTime` is nil
//: a. Createa new `printDepartures2(departureBoard:)` or modify the previous function
//:
//: b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional date into a String
//:
//: c. Call the new or udpated function. It should not print `Optional(2019-05-30 17:09:20 +0000)` for departureTime or for the Terminal.
//:
//: d. Stretch: Format the time string so it displays only the time using a [`DateFormatter`](https://developer.apple.com/documentation/foundation/dateformatter) look at the `dateStyle` (none), `timeStyle` (short) and the `string(from:)` method
//:
//: e. Your output should look like:
//:
//:     Destination: Los Angeles Airline: Delta Air Lines Flight: KL 6966 Departure Time:  Terminal: 4 Status: Canceled
//:     Destination: Rochester Airline: Jet Blue Airways Flight: B6 586 Departure Time: 1:26 PM Terminal:  Status: Scheduled
//:     Destination: Boston Airline: KLM Flight: KL 6966 Departure Time: 1:26 PM Terminal: 4 Status: Scheduled



func printDepartures2(departureBoard: DepartureBoard) {

    for flight in departureBoard.board {
        var departureStr = ""
        if let departureTime = flight.departureTime {
            departureStr = dateFormatter.string(from: departureTime)
        }
        var terminalStr = ""
        if let terminal = flight.terminal {
            terminalStr = terminal
        }
        
    print("Airline: \(flight.airline) Destiniation: \(flight.destination.city) Departure Time: \(departureStr) Terminal: \(terminalStr) STATUS: \(flight.status)")
    }
}
printDepartures2(departureBoard: jfkDepartureBoard)

//: ## 5. Add an instance method to your `DepatureBoard` class (above) that can send an alert message to all passengers about their upcoming flight. Loop through the flights and use a `switch` on the flight status variable.
//: a. If the flight is canceled print out: "We're sorry your flight to \(city) was canceled, here is a $500 voucher"
//:
//: b. If the flight is scheduled print out: "Your flight to \(city) is scheduled to depart at \(time) from terminal: \(terminal)"
//:
//: c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon."
//:
//: d. If the `departureTime` or `terminal` are optional, use "TBD" instead of a blank String
//:
//: e. If you have any other cases to handle please print out appropriate messages
//:
//: d. Call the `alertPassengers()` function on your `DepartureBoard` object below
//:
//: f. Stretch: Display a custom message if the `terminal` is `nil`, tell the traveler to see the nearest information desk for more details.
jfkDepartureBoard.flightAlert()
    




//: ## 6. Create a free-standing function to calculate your total airfair for checked bags and destination
//: Use the method signature, and return the airfare as a `Double`
//:
//:     func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
//:     }
//:
//: a. Each bag costs $25
//:
//: b. Each mile costs $0.10
//:
//: c. Multiply the ticket cost by the number of travelers
//:
//: d. Call the function with a variety of inputs (2 bags, 2000 miles, 3 travelers = $750)
//:
//: e. Make sure to cast the numbers to the appropriate types so you calculate the correct airfare
//:
//: f. Stretch: Use a [`NumberFormatter`](https://developer.apple.com/documentation/foundation/numberformatter) with the `currencyStyle` to format the amount in US dollars.
func calculateAirfare(checkedBags: Double, distance: Double, travelers: Double) -> String {
    let bagCost: Double = 25.00
    let mileCost: Double = 0.10
    let totalBagCost = bagCost * checkedBags
    let totalMileCost = mileCost * distance
    let totalCost = (totalBagCost + totalMileCost) * travelers
    let newCost = NSNumber(value: totalCost)
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    var finalCostStr = ""
    
    if let finalCost = formatter.string(from: newCost) {
        finalCostStr = finalCost
    }
    
    return finalCostStr
}


print(calculateAirfare(checkedBags: 2.00, distance: 2000.00, travelers: 3.00))
