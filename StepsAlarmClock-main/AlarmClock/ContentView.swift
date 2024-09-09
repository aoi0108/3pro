import SwiftUI
import AudioToolbox
import Foundation
import CoreMotion
import AVFoundation
import MediaPlayer

struct ContentView: View {
    @StateObject private var alarmManager = AlarmManager() // AlarmManagerのインスタンスを状態オブジェクトとして保持
    @State private var isShowSetTimeView = false // 時刻設定ビューの表示状態を管理
    @State private var myTimer = Date()

    
    var body: some View {
        NavigationStack {
            VStack {
                // タイマーから時刻を取得
                let hour = calendar.component(.hour, from: myTimer)
                let minute = calendar.component(.minute, from: myTimer)
                
                if !alarmManager.isShowAlert {
                    // アラームが鳴っていない場合のビュー
                    Button(action: {
                        isShowSetTimeView = true
                        alarmManager.isTimerMoving = false
                        UIScreen.main.brightness += 0.01
                    }, label: {
                        Text("\(String(format: "%02d", hour)):\(String(format: "%02d", minute))")
                            .font(.system(size: 90))
                            .bold()
                    })
                    .sheet(isPresented: $isShowSetTimeView) {
                        SetTimeView(myTimer: $myTimer) // 時刻設定ビューを表示
                    }
                    Text("にアラームを鳴らす")
                        .font(.title)
                        .foregroundColor(.primary)
                    
                    Toggle(isOn: $alarmManager.isTimerMoving) {} // タイマーのオンオフを管理
                        .labelsHidden()
                        .onChange(of: alarmManager.isTimerMoving, initial: false) {
                            if alarmManager.isTimerMoving {
                                alarmManager.startTimer(settingTime: myTimer) // タイマーを開始
                                UIScreen.main.brightness = 0.0
                            }
                        }
                        .fixedSize()
                        .scaleEffect(1.5)
                        .padding()
                }
                NavigationLink(destination: QuizView(alarmManager: alarmManager), isActive: $alarmManager.isShowAlert) {
                    EmptyView()
                }
            }
            .preferredColorScheme(.light)
        }
        
        // テストモードを切り替えるスイッチ
        Toggle("テストモード", isOn: $alarmManager.isTestMode)
            .padding()
    }

    
    

}

// プレビュー
struct ContentView_Previews: PreviewProvider {
    @State static var correct = true
    
    static var previews: some View {
        ContentView()
            .environmentObject(AlarmManager()) // プレビューで環境オブジェクトを設定
    }
}
