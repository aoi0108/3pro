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
    @Binding var correct: Bool
    
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
                NavigationLink(destination: QuizView(correct: correct, alarmManager: alarmManager), isActive: $alarmManager.isShowAlert) {
                    EmptyView()
                }
            }
            .preferredColorScheme(.light)
        }
        // テストモードを切り替えるスイッチ
        Toggle("テストモード", isOn: $alarmManager.isTestMode)
            .padding()
    }
<<<<<<< HEAD
=======
    
    func startTimer(settingTime: Date){
        var now = Date()
        var target = settingTime
        
        if now > target{
            target = Calendar.current.date(byAdding: .day, value: 1, to: target)!
        }
        
        var interval = target.timeIntervalSince(now)
        
        
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if !isTimerMoving {
                timer.invalidate()
            }
            now = Date()+50
            if target > now{
                interval -= 1
                let hours = Int(interval) / 3600
                let minutes = Int(interval) % 3600 / 60
                let seconds = Int(interval) % 60
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let formattedTarget = dateFormatter.string(from: target)
                print("\(formattedTarget)まで残り時間: \(hours)時間 \(minutes)分 \(seconds)秒")
            }else{
                alarmStart()
                timer.invalidate()
            }
        }
        
    }
    
    func soundCallback() {
        counter -= 1
        if counter > 0 {
            AudioServicesPlaySystemSound(soundID)
        } else {
            stopAlarm()
        }
    }
    
    func alarmStart() {
        MPVolumeView.setVolume(0.3)
        UIScreen.main.brightness = brightness
        isShowAlert = true
        startCountSteps()
                AudioServicesAddSystemSoundCompletion(soundID, nil, nil, { (_, _) in
                    ContentView().soundCallback()
                }, nil)
                AudioServicesPlaySystemSound(soundID)
        do{
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback)
            musicPlayer = try AVAudioPlayer(data: musicData)
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        }catch{
            print("音の再生に失敗しました。")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 19.0) {
            MPVolumeView.setVolume(1.0)
        }
        // QuizViewに遷移する
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                   self.navigateToQuiz = true
        }
    }
    
    func stopAlarm(){
        isShowAlert = false
        isTimerMoving = false
        counter = 1000
        stopCountSteps()
        musicPlayer.stop()
        AudioServicesRemoveSystemSoundCompletion(soundID)
    }
    
    func startCountSteps(){
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date(), withHandler: {(pedometerData, error) in
                if let e = error {
                    print(e.localizedDescription)
                    return
                }
                guard let data = pedometerData else {
                    return
                }
                steps = Int(truncating: data.numberOfSteps)
            })
        }
    }
    
    func stopCountSteps() {
        pedometer.stopUpdates()
        steps = 0
    }
    
>>>>>>> main
}

// プレビュー
struct ContentView_Previews: PreviewProvider {
    @State static var correct = true
    
    static var previews: some View {
        ContentView(correct: $correct)
            .environmentObject(AlarmManager()) // プレビューで環境オブジェクトを設定
    }
}
