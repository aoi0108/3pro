//
//  MainView.swift
//  AlarmClock
//
//  Created by 平松蒼惟 on 2024/05/15.
//

import SwiftUI

struct MainView: View {
    @AppStorage("score") var correctCount : Int = 0
    @State private var correct: Bool = false
    
    init() {
           // ナビゲーションバーの背景色とタイトルの色を設定
           let appearance = UINavigationBarAppearance()
           appearance.configureWithOpaqueBackground()
           appearance.backgroundColor = UIColor(red: 229/255, green: 211/255, blue: 163/255, alpha: 1.0) // カスタム色
           appearance.titleTextAttributes = [.foregroundColor: Color(red: 162/255, green: 119/255, blue: 6/255)]
           
           UINavigationBar.appearance().standardAppearance = appearance
           UINavigationBar.appearance().scrollEdgeAppearance = appearance
       }
    
    var body: some View {
        
        NavigationStack{
            VStack{
                Text("Level： " + String(correctCount) )
                    .font(.title)
                    .padding()
                Image(selectImageName(for: correctCount))
                    .resizable() // 画像のリサイズを可能にする
                    .aspectRatio(contentMode: .fit) // アスペクト比を維持
                    .frame(width: 200, height: 200) // フレームサイズを設定
                    .padding()
                HStack(spacing: 20)  {
                    
                   
                       NavigationLink(destination: HowToUse()) { // 別のViewに遷移するリンクに変更
                           Image(systemName: "info.circle")
                               .font(.title)
                               .foregroundColor(Color(red: 162/255, green: 119/255, blue: 6/255))
                               .frame(width: 60, height: 60, alignment: .center)
                               .background(Color(red: 229/255, green: 211/255, blue: 163/255))
                               .cornerRadius(20)
                               .overlay(
                                   RoundedRectangle(cornerRadius: 20)
                                       .stroke(Color(red: 162/255, green: 119/255, blue: 6/255), lineWidth: 2)
                               )
                       }
                    
                    NavigationLink(destination: AlarmView()) {
                        Image(systemName: "clock")
                                                   .font(.title) // アイコンのサイズ
                                                   .foregroundColor(Color(red: 162/255, green: 119/255, blue: 6/255))
                                                   .frame(width: 60, height: 60, alignment: .center) // フレームサイズ
                                                   .background(Color(red: 229/255, green: 211/255, blue: 163/255))
                                                   .cornerRadius(20)
                                                   .overlay(
                                                       RoundedRectangle(cornerRadius: 20)
                                                        .stroke(Color(red: 162/255, green: 119/255, blue: 6/255), lineWidth: 2) // 枠線の色と太さを指定

                            )

                    }

                       
                       NavigationLink(destination: Collection()) { // 別のViewに遷移するリンクに変更
                           Image(systemName: "star")
                               .font(.title)
                               .foregroundColor(Color(red: 162/255, green: 119/255, blue: 6/255))
                               .frame(width: 60, height: 60, alignment: .center)
                               .background(Color(red: 229/255, green: 211/255, blue: 163/255))
                               .cornerRadius(20)
                               .overlay(
                                   RoundedRectangle(cornerRadius: 20)
                                       .stroke(Color(red: 162/255, green: 119/255, blue: 6/255), lineWidth: 2)
                               )
                       }
                }
               
            }
            
                       .toolbar {
                           ToolbarItem(placement: .principal) {
                               Text("Home")
                                   .foregroundColor(Color(red: 162/255, green: 119/255, blue: 6/255))
                                   .font(.headline)
                           }
                       }
            .navigationBarBackButtonHidden(true) // これで戻るボタンを隠す
        }
        .preferredColorScheme(.light) // ライトモードを強制
        
    }
    
    func selectImageName(for count: Int) -> String {
         switch count {
         case 0:
             return "coffeecup"
         case 1:
             return "coffee-jelly"
         case 2:
             return "end-jelly"
         case 3:
             return "coffeecup"
         case 4:
             return "pudding"
         case 5:
             return "pudding-cream"
         case 6:
             return "pudding-end"
         case 7:
             return "sodacup"
         case 8:
             return "soda-ice"
         case 9:
             return "soda-soda"
         case 10:
             return "soda-float"
         case 11:
             return "soda-fin"
         case 12:
             return "sodacup"
         case 13:
             return "parfeit-cereal"
         case 14:
             return "parfeit-ice"
         case 15:
             return "parfeit-cream"
         case 16:
             return "parfeit-berry"
         case 17:
             return "parfeit-fin"
             
         default:
             return "neko"
         }
     }
}

#Preview {
    MainView()
}
