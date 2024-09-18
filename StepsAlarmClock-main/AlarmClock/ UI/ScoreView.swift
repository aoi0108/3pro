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
                // 背景色を正解/不正解で変更
                if isCorrect {
                    Color("beige").opacity(0.3).edgesIgnoringSafeArea(.all)
                } else {
                    Color.gray.opacity(0.8).edgesIgnoringSafeArea(.all)
                }
                
                VStack(spacing: 40) {
                    // 合計スコアのテキスト
                    VStack(spacing: 10) {
                        Text("Total Score")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color("brown"))
                        
                        // スコア表示
                        Text("\(correctCount)")
                            .font(.system(size: 80, weight: .bold))
                            .foregroundColor(Color("brown"))
                    }
                    
                    if isCorrect {
                        VStack(spacing: 20) {
                            Text("You've earned 1 point!")
                                .font(.headline)
                                .foregroundColor(Color("red"))
                            
                            // アラーム停止ボタン
                            Button {
                                stopAlarm()
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Stop Alarm")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .frame(width: 220, height: 60)
                                    .background(Color("red"))
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                            }
                        }
                    }
                }
                .padding(.horizontal, 30)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationBarHidden(true)
    }
    
    // アラーム停止関数
    private func stopAlarm() {
        alarmManager.stopAlarm()
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(correctCount: 0, alarmManager: AlarmManager(), isCorrect: true)
    }
}
