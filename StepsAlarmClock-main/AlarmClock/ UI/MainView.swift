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

                    NavigationLink(destination: CollectionView(collectedItems: viewModel.collectedItems, viewModel:MainViewModel())) {
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
            }
            .toolbarBackground(Color("beige"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Home")
                        .foregroundColor(Color("brown"))
                        .font(.headline)
                       
                }
                
            }
            
            
        }
        .preferredColorScheme(.light)
    }
}

