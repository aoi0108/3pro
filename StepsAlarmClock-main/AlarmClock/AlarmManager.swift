import SwiftUI
import AudioToolbox
import Foundation
import CoreMotion
import AVFoundation
import MediaPlayer

// 定数の定義
let calendar = Calendar.current
private let soundID = SystemSoundID(kSystemSoundID_Vibrate)
private var counter = 1000
// 音楽ファイルの読み込み
let musicData = NSDataAsset(name: "BrainPlaybackMusic")!.data
var musicPlayer: AVAudioPlayer!

// アラームの管理クラス
class AlarmManager: ObservableObject {
    @Published var isShowAlert = false // アラームが鳴っているかどうかを管理
    @Published var isTimerMoving = false // タイマーが動いているかどうかを管理
    @Published var navigateToQuiz = false // クイズ画面への遷移を管理
    @Published var isTestMode = false // テストモードフラグ
    @Published var soundLevel = AVAudioSession.sharedInstance().outputVolume // 現在の音量レベル
    let brightness: CGFloat = UIScreen.main.brightness // 現在の画面の明るさ

    // タイマーの開始
    func startTimer(settingTime: Date) {
        var now = Date()
        var target = settingTime
        
        // テストモードの場合、現在時刻に40秒を加算
        if isTestMode {
            now = now.addingTimeInterval(55)
        }

        // 目標時間が過去の場合、次の日に設定
        if now > target {
            target = Calendar.current.date(byAdding: .day, value: 1, to: target)!
        }
        
        var interval = target.timeIntervalSince(now)
        
        // 1秒ごとのタイマー設定
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if !self.isTimerMoving {
                timer.invalidate()
            }
            if interval > 0  {
                interval -= 1
                let hours = Int(interval) / 3600
                let minutes = Int(interval) % 3600 / 60
                let seconds = Int(interval) % 60
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let formattedTarget = dateFormatter.string(from: target)
                print("\(formattedTarget)まで残り時間: \(hours)時間 \(minutes)分 \(seconds)秒")
            } else {
                self.alarmStart()
                timer.invalidate()
            }
        }
    }
    
    // サウンドのコールバック
    func soundCallback() {
        counter -= 1
        if counter > 0 {
            AudioServicesPlaySystemSound(soundID)
        } else {
            stopAlarm()
        }
    }
    
    // アラームの開始
    func alarmStart() {
        // 音量を0.3に設定
        MPVolumeView.setVolume(0.3)
        
        // 画面の明るさを元に戻す
        UIScreen.main.brightness = brightness
        
        // アラーム表示フラグをオンにする
        isShowAlert = true
        
        // サウンド再生完了時のコールバックを追加
        AlarmManager.addSoundCompletion()
        
        // システムサウンドを再生する
        AudioServicesPlaySystemSound(soundID)
        
        do {
            // オーディオセッションのインスタンスを取得
            let audioSession = AVAudioSession.sharedInstance()
            
            // 再生カテゴリを設定
            try audioSession.setCategory(.playback)
            
            // 音楽プレイヤーを初期化し、音楽データを設定
            musicPlayer = try AVAudioPlayer(data: musicData)
            
            // 無限ループで音楽を再生
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch {
            // 音楽再生に失敗した場合のエラーメッセージ
            print("音の再生に失敗しました。")
        }
        

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigateToQuiz = true
        }
    }

    
    // アラームの停止
    func stopAlarm() {
        isShowAlert = false
        isTimerMoving = false
        counter = 1000
        AudioServicesRemoveSystemSoundCompletion(soundID)
    }
    
    // サウンドの完了処理を追加
    static func addSoundCompletion() {
        AudioServicesAddSystemSoundCompletion(soundID, nil, nil, soundCompletionCallback, nil)
    }
    
    // サウンド完了時のコールバック
    static let soundCompletionCallback: AudioServicesSystemSoundCompletionProc = { _, _ in
        let alarmManager = AlarmManager()
        alarmManager.soundCallback()
    }
}
