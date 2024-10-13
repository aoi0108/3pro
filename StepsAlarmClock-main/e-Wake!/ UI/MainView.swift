import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel() // Bind ViewModel to the view



    var body: some View {
        
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    
                    HStack {
                        Text("Level")
                            .font(.title3)
                            .foregroundColor(Color("brown"))
                            .bold() // 強調
                        
                        Text("\(viewModel.correctCount)")
                            .font(.title3)
                            .foregroundColor(Color("brown"))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color("beige"))
                            .cornerRadius(20)
                        
                    }
                    HStack {
                        Text("Status")
                            .font(.title3)
                            .foregroundColor(Color("brown"))
                            .bold() // 強調
                        
                        Text("\(viewModel.statusName(for: viewModel.correctCount))")
                            .font(.title3)
                            .foregroundColor(Color("brown"))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color("beige"))
                            .cornerRadius(20)
                        
                    }
                    
                    if let itemCount = viewModel.collectedItems[viewModel.statusName(for: viewModel.correctCount)] {
                        HStack {
                            Text("Collected")
                                .font(.title3)
                                .foregroundColor(Color("brown"))
                                .bold() // 強調
                            
                            Text("\(itemCount)")
                                .font(.title3)
                                .foregroundColor(Color("brown"))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(Color("beige"))
                                .cornerRadius(20)
                            
                        }
                    }
                    
                }
                
                Image(viewModel.selectImageName(for: viewModel.correctCount))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
                
                
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
                                VStack {
                                    Spacer()
                                    Text("Home")
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


#Preview {
   MainView()
}
