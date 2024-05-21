//
//  ScoreView.swift
//  AlarmClock
//
//  Created by 羽田野真央 on 2024/05/15.
//

import SwiftUI

struct ScoreView: View {
    let correctCount: Int
    
    var body: some View {
        ZStack{
            if(correctCount == 0){
                RainyBackground()
            }else{
                SunnyBackground()
            }
            
            VStack {
                Text("Your score is ...")
                    .font(.title)
                
                Text("\(correctCount)")
                    .font(.largeTitle)
                    .padding()
            }
        }
        
        
            }
}
#Preview {
    ScoreView(correctCount: 0)
}
