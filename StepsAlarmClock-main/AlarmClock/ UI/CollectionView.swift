import SwiftUI

struct CollectionView: View {
    var collectedItems: [String: Int] // Dictionary of collected items
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(collectedItems.sorted(by: { $0.key < $1.key }), id: \.key) { item, count in
                    if count > 0 {
                        HStack {
                            Image(selectImageName(for: item, count: count)) // Display the image based on count and item
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200) // Adjust the size of the image
                            
                            VStack(alignment: .leading) {
                                Text(item) // Display the item name
                                    .font(.headline)
                                
                                Text("Collected: ✖️\(count)") // Display count of each collected item
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color("beige").opacity(0.4))
                        .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Collection")
      
    }
    
    // Helper function to map item name to corresponding image based on count
    func selectImageName(for item: String, count: Int) -> String {
        switch item {
        case "Coffee Jelly":
            return count >= 2 ? "end-jelly" : "coffee-jelly" // Case 2
        case "Pudding":
            return count >= 6 ? "pudding-end" : "pudding" // Case 6
        case "Cream Soda":
            return count >= 11 ? "soda-fin" : "soda-soda" // Case 11
        case "Parfait":
            return count >= 16 ? "parfeit-fin" : "parfeit-cereal" // Case 16
        default:
            return "unknown" // Provide a default or fallback image if needed
        }
    }
}

struct CollectionView_PreviewWrapper: View {
    var body: some View {
        CollectionView(collectedItems: [
            "Coffee Jelly": 3,
            "Pudding": 7,
            "Cream Soda": 11,
            "Parfait": 16
        ])
        .onAppear {
            // プレビューで UserDefaults に score を 30 に設定
            UserDefaults.standard.set(30, forKey: "score")
        }
    }
}

#Preview{
    CollectionView_PreviewWrapper()
}
