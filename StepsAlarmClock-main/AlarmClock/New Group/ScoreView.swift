import SwiftUI
import MediaPlayer
import AudioToolbox

struct ScoreView: View {
    let correctCount: Int
    @ObservedObject var alarmManager: AlarmManager
    let isCorrect: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

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
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("アラーム停止")
                                .font(.title)
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
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
