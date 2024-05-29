//
//  MainView.swift
//  AlarmClock
//
//  Created by 平松蒼惟 on 2024/05/15.
//

import SwiftUI

struct MainView: View {
    @AppStorage("score") var correctCount : Int = 0
    
    var body: some View {
        
        NavigationStack{
            VStack{
                Text("レベル： " + String(correctCount) )
                    .font(.title)
                    .padding()
                Image("neko")
                    .padding()
                HStack {
                    NavigationLink(destination: ContentView()) {
                        Text("アラームを設定する")
                            .foregroundColor(.blue)
                            .font(.title)
                            .frame(width: 300, height: 60, alignment: .center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    }
                }
               
            }
            
            
        }
        
    }
}

#Preview {
    MainView()
}
