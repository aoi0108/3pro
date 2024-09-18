//
//  MainViewModel.swift
//  AlarmClock
//
//  Created by 羽田野真央 on 2024/09/18.
//
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var correctCount: Int = 0
    @Published var collectedItems: [String: Int] = [:]

    @AppStorage("score") private var storedCorrectCount: Int = 0
    @AppStorage("collectedItems") private var collectedItemData: Data = Data()

    init() {
        loadState()
    }

    // 状態をロードする
    func loadState() {
        correctCount = storedCorrectCount
        if let decodedData = try? JSONDecoder().decode([String: Int].self, from: collectedItemData) {
            collectedItems = decodedData
        } else {
            // 初期化：初めての場合
            collectedItems = ["Coffee Jelly": 0, "Pudding": 0, "Cream Soda": 0, "Parfait": 0]
        }
    }

    // 特定のカウントに達したときにコレクションを更新
    func updateCollection() {
        let key = statusName(for: correctCount)
        
        // correctCountが2,6,11,16のときに対応するコレクションを更新
        switch correctCount % 17 {
        case 2:
            collectedItems["Coffee Jelly", default: 0] += 1
        case 6:
            collectedItems["Pudding", default: 0] += 1
        case 11:
            collectedItems["Cream Soda", default: 0] += 1
        case 16:
            collectedItems["Parfait", default: 0] += 1
        default:
            break
        }

        print("Updated Collection: \(collectedItems)")
        saveState() // 状態を保存
    }

    // 状態を保存する
    func saveState() {
        storedCorrectCount = correctCount
        do {
            let encodedData = try JSONEncoder().encode(collectedItems)
            collectedItemData = encodedData
            print("State saved successfully. Encoded Data: \(encodedData)")
        } catch {
            print("Failed to encode and save collectedItems: \(error.localizedDescription)")
        }
    }

    // データをリセットするメソッドを追加
    func resetData() {
        correctCount = 0
        collectedItems = ["Coffee Jelly": 0, "Pudding": 0, "Cream Soda": 0, "Parfait": 0]
        saveState() // 状態を保存
    }

    // 現在のカウントに基づいてステータス名を取得する
    func statusName(for count: Int) -> String {
        switch count % 17 {
        case 0, 1, 2: return "Coffee Jelly"
        case 3, 4, 5, 6: return "Pudding"
        case 7, 8, 9, 10, 11, 12: return "Cream Soda"
        case 13, 14, 15, 16: return "Parfait"
        default: return "Unknown"
        }
    }

    // カウントに基づいて適切な画像を選択する
    func selectImageName(for count: Int) -> String {
        let adjustedCount = (count % 17)
        switch adjustedCount {
        case 0: return "coffeecup"
        case 1: return "coffee-jelly"
        case 2: return "end-jelly"
        case 3: return "coffeecup"
        case 4: return "pudding"
        case 5: return "pudding-cream"
        case 6: return "pudding-end"
        case 7: return "sodacup"
        case 8: return "soda-ice"
        case 9: return "soda-soda"
        case 10: return "soda-float"
        case 11: return "soda-fin"
        case 12: return "sodacup"
        case 13: return "parfeit-cereal"
        case 14: return "parfeit-ice"
        case 15: return "parfeit-cream"
        case 16: return "parfeit-fin"
        default: return "coffeecup"
        }
    }
}
