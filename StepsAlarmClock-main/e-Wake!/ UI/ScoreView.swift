import SwiftUI
import MediaPlayer
import AudioToolbox

struct ScoreView: View {
    let correctCount: Int
    @ObservedObject var alarmManager: AlarmManager
    let isCorrect: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var showCongratsPopup: Bool = false
    
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
                            
                            
                            HStack{
                                // アラーム停止ボタン
                                Button {
                                    stopAlarm()
                                  //presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Text("Stop Alarm")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .frame(width: 200, height: 60)
                                        .background(Color("green"))
                                        .foregroundColor(.white)
                                        .cornerRadius(15)
                                        .shadow(radius: 5)
                                }
                                //SNSシェアボタン
                                Button {
                                    shareOnTwitter()
                                } label: {
                                    Text(Image(systemName: "square.and.arrow.up"))
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .frame(width: 100, height: 60)
                                        .background(Color("green"))
                                        .foregroundColor(.white)
                                        .cornerRadius(15)
                                        .shadow(radius: 5)
                                }
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
                .onAppear {
                                    // ポイントに達したときにポップアップを表示
                                    if shouldShowCongratsPopup(for: correctCount) {
                                        showCongratsPopup = true
                                    }
                                }
                                // ポップアップ表示
                                .sheet(isPresented: $showCongratsPopup) {
                                    CongratsPopupView(imageName: selectCongratsImage(for: correctCount))
                                }
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

// ポップアップ表示条件
   func shouldShowCongratsPopup(for count: Int) -> Bool {
       let adjustedCount = count % 17
       return adjustedCount == 2 || adjustedCount == 6 || adjustedCount == 11 || adjustedCount == 16
}

func selectCongratsImage(for count: Int) -> String {
     let adjustedCount = count % 17
     switch adjustedCount {
     case 2: return "coffee-congrats"
     case 6: return "pudding-congrats"
     case 11: return "soda-congrats"
     case 16: return "parfeit-congrats"
     default: return "coffee-congrats"
     }
 }


func shareOnTwitter() {

        //シェアするテキストを作成
        let text = "I've done it today!"
        let hashTag = "#e-Wake!"
        let completedText = text + "\n" + hashTag

        //作成したテキストをエンコード
        let encodedText = completedText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        //エンコードしたテキストをURLに繋げ、URLを開いてツイート画面を表示させる
        if let encodedText = encodedText,
            let url = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)") {
            UIApplication.shared.open(url)
        }
    }
