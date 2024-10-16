import SwiftUI

struct SplashScreen: View {
    @State private var isLoading = true

    var body: some View {
        if isLoading {
            ZStack {
                Color("beige")
                    .ignoresSafeArea()
 

                VStack{
                    Image("title")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    Image("soda-fin")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    withAnimation {
                        isLoading = false
                    }
                }
            }
        } else {
            MainView()
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

