//
//  MainView.swift
//  AlarmClock
//
//  Created by 平松蒼惟 on 2024/05/15.
//

import SwiftUI

struct MainView: View {
    
    @State private var myTimer = Date()
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("レベル：1")
                Image("neko")
                HStack {
                    NavigationLink(destination: SetTimeView(myTimer: $myTimer)) {
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
