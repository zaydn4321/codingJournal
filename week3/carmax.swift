import Foundation

// models and logic for carmax

struct Vehicle {
    let model: String
    let price: Double
    let horsepower: Double
    let fuelCost: Double
}

struct Preferences {
    let horsepowerWeight: Double
    let priceWeight: Double
    let fuelCostWeight: Double
}

func scoreVehicle(vehicle: Vehicle, preferences: Preferences) -> Double {
    return vehicle.horsepower * preferences.horsepowerWeight
           - vehicle.price * preferences.priceWeight
           - vehicle.fuelCost * preferences.fuelCostWeight
}

func compareVehicles(vehicles: [Vehicle], preferences: Preferences) -> [(vehicle: Vehicle, score: Double)] {
    guard vehicles.count == 3 else {
        print("please provide exactly three vehicles for comparison")
        return []
    }
    let scoredVehicles = vehicles.map { vehicle in
        (vehicle, scoreVehicle(vehicle: vehicle, preferences: preferences))
    }
    return scoredVehicles.sorted { $0.score > $1.score }
}

// sample usage

let vehicle1 = Vehicle(model: "sporty", price: 30000, horsepower: 250, fuelCost: 1200)
let vehicle2 = Vehicle(model: "economy", price: 20000, horsepower: 150, fuelCost: 800)
let vehicle3 = Vehicle(model: "luxury", price: 50000, horsepower: 300, fuelCost: 1500)

let vehicles = [vehicle1, vehicle2, vehicle3]
let userPreferences = Preferences(horsepowerWeight: 1.0, priceWeight: 0.0005, fuelCostWeight: 0.0)
let vehicleComparisons = compareVehicles(vehicles: vehicles, preferences: userPreferences)

for (vehicle, score) in vehicleComparisons {
    print("\(vehicle.model): \(String(format: "%.2f", score))")
}
