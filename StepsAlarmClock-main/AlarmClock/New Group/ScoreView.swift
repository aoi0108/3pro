//
//  ScoreView.swift
//  AlarmClock
//
//  Created by 羽田野真央 on 2024/05/15.
//

import SwiftUI
import MediaPlayer

struct ScoreView: View {
    let correctCount: Int
    @ObservedObject var alarmManager: AlarmManager // alarmManagerをプロパティとして追加
    let isCorrect:Bool
    var body: some View {
        ZStack{
            if isCorrect {
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
                if(isCorrect == true){
                    Button {     //音楽を止める
                        musicPlayer.stop()
                        } label: {
                            Text("アラーム停止")
                                .font(.title)
                                .foregroundStyle(.white)
                        }
                }
                
            }
            
        }
        
        
            }
}

struct ScoreView_Previews: PreviewProvider {
    @State static var correct = true
    
    static var previews: some View {
        ScoreView(correctCount: 0, alarmManager: AlarmManager(), isCorrect: true)
    }
    
}
