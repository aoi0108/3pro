//
//  ScoreView.swift
//  AlarmClock
//
//  Created by 羽田野真央 on 2024/05/15.
//

import SwiftUI

struct ScoreView: View {
    let correctCount: Int
    let isCorrect: Bool
    
    var body: some View {
        ZStack{
            if isCorrect{
                SunnyBackground()
            }else{
                RainyBackground()
            }
            
            VStack {
                Text("You've got 1 point!")
                    .padding()
                Text("Your total score is ...")
                    .font(.title)
                
                Text("\(correctCount)")
                    .font(.largeTitle)
                    .padding()
            }
        }
        
        
            }
}
#Preview {
    ScoreView(correctCount: 0, isCorrect: true)
}
