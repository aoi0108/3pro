// CollectionView
import SwiftUI
struct CollectionView: View {
    var collectedItems: [String: Int] // Dictionary of collected items
    
    var body: some View {
        VStack {
            Text("Collected Items")
                .font(.title)
                .padding()
            
            List(collectedItems.sorted(by: { $0.key < $1.key }), id: \.key) { item, count in
                HStack {
                    Image(selectImageName(for: item)) // Display the image for the item
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40) // Adjust the size of the image
                    
                    Text(item) // Display the item name
                    
                    Spacer()
                    Text("✖️\(count)") // Display count of each collected item
                }
            }
        }
        .navigationTitle("Collection")
        .padding()
    }
    
    // Helper function to map item name to corresponding image
    func selectImageName(for item: String) -> String {
        switch item {
        case "Coffee Cup": return "coffeecup"
        case "Coffee Jelly": return "coffee-jelly"
        case "End Jelly": return "end-jelly"
        case "プリン": return "pudding"
        case "Pudding Cream": return "pudding-cream"
        case "Pudding End": return "pudding-end"
        case "Soda Cup": return "sodacup"
        case "Soda Ice": return "soda-ice"
        case "Soda Soda": return "soda-soda"
        case "Soda Float": return "soda-float"
        case "Soda Fin": return "soda-fin"
        case "Parfait Cereal": return "parfeit-cereal"
        case "Parfait Ice": return "parfeit-ice"
        case "Parfait Cream": return "parfeit-cream"
        case "Parfait Fin": return "parfeit-fin"
        default: return "unknown" // Provide a default or fallback image if needed
        }
    }
}

