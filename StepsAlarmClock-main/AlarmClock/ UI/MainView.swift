import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel() // Bind ViewModel to the view

    init() {
        // ナビゲーションバーの外観を設定
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "beige") // 背景色を設定
        appearance.titleTextAttributes = [.foregroundColor: UIColor.brown] // タイトルの文字色を設定
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

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
