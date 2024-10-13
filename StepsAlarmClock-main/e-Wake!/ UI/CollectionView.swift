import SwiftUI

// CollectionView
struct CollectionView: View {
    var collectedItems: [String: Int]
    @ObservedObject var viewModel: MainViewModel
    
    // 順番を指定するリスト
    let displayOrder = ["Coffee Jelly", "Pudding", "Cream Soda", "Parfait"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(displayOrder, id: \.self) { item in
                        if let count = collectedItems[item], count > 0 {
                            HStack {
                                Image(selectImageName(for: item, count: count))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height: 200)
                                
                                VStack(alignment: .leading) {
                                    Text(item)
                                        .font(.headline)
                                        .foregroundColor(Color("brown"))
                                    
                                    Text("Collected: ×\(count)")
                                        .font(.subheadline)
                                        .foregroundColor(Color("brown"))
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
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Spacer()
                            Text("Collection")
                                .foregroundColor(Color("brown"))
                                .font(.title)
                                .bold()
                        }
                    }
                }
            }
            .preferredColorScheme(.light)
        }
    }
    

    func selectImageName(for item: String, count: Int) -> String {
        switch item {
        case "Coffee Jelly":
            return "end-jelly" // Case 2
        case "Pudding":
            return "pudding-end"  // Case 6
        case "Cream Soda":
            return "soda-fin" // Case 11
        case "Parfait":
            return "parfeit-fin" // Case 16
        default:
            return "unknown"
        }
    }
}


struct MainView_PreviewWrapper: View {
    var body: some View {
        MainView()
            .onAppear {
                UserDefaults.standard.set(4, forKey: "score")
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
            "Coffee Jelly": 2,
            "Pudding": 6,
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
