//
//  LaunchScreen.swift
//  AlarmClock
//
//  Created by 平松蒼惟 on 2024/09/22.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var isLoading = true

    var body: some View {
        if isLoading {
            ZStack {
                Color("beige")
                    .ignoresSafeArea()
//タイトル画像挿入箇所
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
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
        LaunchScreen()
    }
}
