import SwiftUI

// enum to represent different car categories available in the app
enum CarCategory: String, CaseIterable, Identifiable {
    case sporty = "sporty"
    case economy = "economy"
    case luxury = "luxury"
    
    // required for identifiable conformance
    var id: String { self.rawValue }
}

// static struct to keep track of the current selection across the app
struct CarSelection {
    // static variable to store the selected car category
    static var selectedCategory: CarCategory = .sporty
}

// main view for the carmax front end
struct CarMaxFrontEnd: View {
    // state variable to hold the user selection locally
    @State private var selectedCategory: CarCategory = CarSelection.selectedCategory

    var body: some View {
        VStack(spacing: 20) {
            // header text for the picker
            Text("choose a car category")
                .font(.headline)
            
            // picker to select a car category from the available options
            Picker("car category", selection: $selectedCategory) {
                ForEach(CarCategory.allCases) { category in
                    Text(category.rawValue.capitalized).tag(category)
                }
            }
            .pickerStyle(SegmentedPickerStyle())  // using a segmented style for a cleaner look
            .padding()

            // button to confirm the selection
            Button(action: {
                // update the static variable with the current selection
                CarSelection.selectedCategory = selectedCategory
                // for debugging purposes, print the selected category
                print("selected category: \(selectedCategory.rawValue)")
            }) {
                Text("confirm selection")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

struct CarMaxFrontEnd_Previews: PreviewProvider {
    static var previews: some View {
        CarMaxFrontEnd()
    }
}
