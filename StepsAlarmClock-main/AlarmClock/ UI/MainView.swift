import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel() // Bind ViewModel to the view

    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("level: \(viewModel.correctCount)")
                        .font(.title3)
                        .foregroundColor(Color("brown"))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color("beige"))
                        .cornerRadius(20)

                    Text("status: \(viewModel.statusName(for: viewModel.correctCount))")
                        .font(.title3)
                        .foregroundColor(Color("brown"))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color("beige"))
                        .cornerRadius(20)

                    if let itemCount = viewModel.collectedItems[viewModel.statusName(for: viewModel.correctCount)] {
                        Text("Collected count: \(itemCount)")
                            .font(.title3)
                            .foregroundColor(Color("brown"))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color("beige"))
                            .cornerRadius(20)
                    }
                }

                Image(viewModel.selectImageName(for: viewModel.correctCount))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding()

                HStack(spacing: 20) {
                    NavigationLink(destination: HowToUse()) {
                        Image(systemName: "info.circle")
                            .font(.title)
                            .foregroundColor(Color("brown"))
                            .frame(width: 60, height: 60, alignment: .center)
                            .background(Color("beige"))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("brown"), lineWidth: 2)
                            )
                    }

                    NavigationLink(destination: AlarmView()) {
                        Image(systemName: "clock")
                            .font(.title)
                            .foregroundColor(Color("brown"))
                            .frame(width: 60, height: 60, alignment: .center)
                            .background(Color("beige"))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("brown"), lineWidth: 2)
                            )
                    }

                    NavigationLink(destination: CollectionView(collectedItems: viewModel.collectedItems)) {
                        Image(systemName: "star")
                            .font(.title)
                            .foregroundColor(Color("brown"))
                            .frame(width: 60, height: 60, alignment: .center)
                            .background(Color("beige"))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("brown"), lineWidth: 2)
                            )
                    }
                }

                // 初期化ボタンを追加
                Button(action: {
                    viewModel.resetData() // 初期化ロジックを実行
                }) {
                    Text("Reset Level and Collection")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Home")
                        .foregroundColor(Color("brown"))
                        .font(.headline)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .preferredColorScheme(.light)
    }
}

class MainViewModel: ObservableObject {
    @Published var correctCount: Int = 0
    @Published var collectedItems: [String: Int] = [:]

    @AppStorage("score") private var storedCorrectCount: Int = 0
    @AppStorage("collectedItems") private var collectedItemData: Data = Data()

    init() {
        loadState()
    }

    // 状態をロードする
    func loadState() {
        correctCount = storedCorrectCount
        if let decodedData = try? JSONDecoder().decode([String: Int].self, from: collectedItemData) {
            collectedItems = decodedData
        }
    }

    // データをリセットするメソッドを追加
    func resetData() {
        correctCount = 0
        collectedItems = ["Coffee Jelly": 0, "Pudding": 0, "Cream Soda": 0, "Parfait": 0]
        saveState() // 状態を保存
    }

    func updateCollection() {
        let key = statusName(for: correctCount)
        print("\(key):\(collectedItems[key] ?? 0)")
        
    }

    // 状態を保存する
    private func saveState() {
        storedCorrectCount = correctCount
        if let encodedData = try? JSONEncoder().encode(collectedItems) {
            collectedItemData = encodedData
        }
    }

    // 現在のカウントに基づいてステータス名を取得する
    func statusName(for count: Int) -> String {
        switch count % 17 {
        case 0, 1, 2: return "Coffee Jelly"
        case 3, 4, 5, 6: return "Pudding"
        case 7, 8, 9, 10, 11, 12: return "Cream Soda"
        case 13, 14, 15, 16: return "Parfait"
        default: return "Unknown"
        }
    }

    // カウントに基づいて適切な画像を選択する
    func selectImageName(for count: Int) -> String {
        let adjustedCount = (count % 17)
        switch adjustedCount {
        case 0: return "coffeecup"
        case 1: return "coffee-jelly"
        case 2: return "end-jelly"
        case 3: return "coffeecup"
        case 4: return "pudding"
        case 5: return "pudding-cream"
        case 6: return "pudding-end"
        case 7: return "sodacup"
        case 8: return "soda-ice"
        case 9: return "soda-soda"
        case 10: return "soda-float"
        case 11: return "soda-fin"
        case 12: return "sodacup"
        case 13: return "parfeit-cereal"
        case 14: return "parfeit-ice"
        case 15: return "parfeit-cream"
        case 16: return "parfeit-fin"
        default: return "coffeecup"
        }
    }
}

// Preview Wrapper for testing
struct MainView_PreviewWrapper: View {
    var body: some View {
        MainView()
            .onAppear {
                // プレビューで UserDefaults に値を設定
                UserDefaults.standard.set(4, forKey: "score") // `score` を 5 に設定
            }
    }
}

#Preview {
    MainView_PreviewWrapper()
}
