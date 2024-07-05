import SwiftUI
import MediaPlayer
import AudioToolbox
import SwiftUI


struct ScoreView: View {
    let correctCount: Int
    @ObservedObject var alarmManager: AlarmManager // alarmManagerをプロパティとして追加
    let isCorrect: Bool
 
    
    var body: some View {
        NavigationView {
            ZStack {
                if isCorrect {
                    SunnyBackground()
                } else {
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
                    
                    if isCorrect {
                        Button {
                            stopAlarm()
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
    
    private func stopAlarm() {
        musicPlayer.stop()
        AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate)
        AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(correctCount: 0, alarmManager: AlarmManager(), isCorrect: true)
    }
}
