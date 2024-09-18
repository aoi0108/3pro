import SwiftUI

// CollectionView
struct CollectionView: View {
    var collectedItems: [String: Int] // Collected items dictionary
    @ObservedObject var viewModel: MainViewModel
 
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(collectedItems.sorted(by: { $0.key < $1.key }), id: \.key) { item, count in
                        if count > 0 {
                            HStack {
                                Image(selectImageName(for: item, count: count)) // Display image based on count and item
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height: 200) // Adjust image size
                                
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
                    Spacer()
                    Button(action: {
                        viewModel.resetData() // 初期化ロジックを実行
                    }) {
                        Text("Reset Collection")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("red"))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Collection")
                            .foregroundColor(Color("brown"))
                            .font(.headline)
                    }
                }
            }
            .preferredColorScheme(.light)
        }
    }
    // Helper function to map item name to corresponding image based on count
    func selectImageName(for item: String, count: Int) -> String {
        switch item {
        case "Coffee Jelly":
            return count >= 3 ? "coffee-jelly" : "end-jelly" // Case 2
        case "Pudding":
            return count >= 6 ? "pudding" : "pudding-end"  // Case 6
        case "Cream Soda":
            return count >= 11 ? "soda-soda" : "soda-fin" // Case 11
        case "Parfait":
            return count >= 16 ? "parfeit-cereal" : "parfeit-fin" // Case 16
        default:
            return "unknown" // Provide default or fallback image if needed
        }
    }
}

// Preview for MainView
struct MainView_PreviewWrapper: View {
    var body: some View {
        MainView()
            .onAppear {
                UserDefaults.standard.set(4, forKey: "score") // Preview with score set to 4
            }
    }
}

#Preview {
    MainView_PreviewWrapper()
}

// Preview for CollectionView
struct CollectionView_PreviewWrapper: View {
    @StateObject var viewModel = MainViewModel() // Initialize MainViewModel
    
    var body: some View {
        CollectionView(collectedItems: [
            "Coffee Jelly": 3,
            "Pudding": 7,
            "Cream Soda": 11,
            "Parfait": 16
        ], viewModel: viewModel) // Pass initialized viewModel
        .onAppear {
            UserDefaults.standard.set(30, forKey: "score") // Set score to 30 for preview
        }
    }
}

#Preview {
    CollectionView_PreviewWrapper()
}
