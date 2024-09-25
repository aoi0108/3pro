import SwiftUI

struct SplashScreen: View {
    @State private var isLoading = true

    var body: some View {
        if isLoading {
            ZStack {
                Color("beige")
                    .ignoresSafeArea()
 
//画像挿入箇所
//                Image("soda-fin")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .padding()
                
                
                Image("soda-fin")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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

