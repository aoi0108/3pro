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
                    Color.gray.opacity(0.3).edgesIgnoringSafeArea(.all)
                }
                
                VStack(spacing: 50) {
                    if isCorrect {
                        VStack(spacing: 20) {
                            // 正解アイコン
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .foregroundColor(Color("green"))
                                .frame(width: 80, height: 80)
                            
                            Text("You've earned 1 point!")
                                .font(.title2)
                                .foregroundColor(Color("green"))
                            /*
                            // 合計スコアのテキスト
                            VStack(spacing: 10) {
                                Text("Total Score")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(isCorrect ? Color("brown") : Color.white)
                                
                                // スコア表示
                                Text("\(correctCount)")
                                    .font(.system(size:40, weight: .bold))
                                    .foregroundColor(isCorrect ? Color("brown") : Color.white)
                            }*/
                            // アラーム停止ボタン
                            Button {
                                stopAlarm()
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Stop Alarm")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .frame(width: 220, height: 60)
                                    .background(Color("green"))
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                            }
                        }
                    } else {
                        VStack(spacing: 20) {
                            // 残念アイコン
                            Image(systemName: "exclamationmark.triangle.fill")
                                .resizable()
                                .foregroundColor(Color("red"))
                                .frame(width: 80, height: 80)
                            
                            // 残念メッセージ
                            Text("That's wrong!")
                                .font(.title2)
                                .foregroundColor(Color("red"))
                            
                        }
                    }
                }
                .padding(.horizontal, 40)
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
        ScoreView(correctCount: 0, alarmManager: AlarmManager(), isCorrect: false)
    }
}

struct ScoreView_Previews_true: PreviewProvider {
    static var previews: some View {
        ScoreView(correctCount: 0, alarmManager: AlarmManager(), isCorrect: true)
    }
}
