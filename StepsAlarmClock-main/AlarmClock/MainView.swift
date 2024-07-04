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
    var body: some View {
        
        NavigationStack{
            VStack{
                Text("レベル： " + String(correctCount) )
                    .font(.title)
                    .padding()
                Image(selectImageName(for: correctCount))
                    .resizable() // 画像のリサイズを可能にする
                    .aspectRatio(contentMode: .fit) // アスペクト比を維持
                    .frame(width: 200, height: 200) // フレームサイズを設定
                    .padding()
                HStack {
                    NavigationLink(destination: ContentView(correct: $correct)) {
                        Text("アラームを設定する")
                            .foregroundColor(.blue)
                            .font(.title)
                            .frame(width: 300, height: 60, alignment: .center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    }
                }
               
            }
            
            
        }
        
    }
    
    func selectImageName(for count: Int) -> String {
         switch count {
         case 0:
             return "image/coffeecup"
         case 1:
             return "image/coffee-jelly"
         case 2:
             return "image/end-jelly"
         case 3:
             return "image/coffeecup"
         case 4:
             return "image/pudding"
         case 5:
             return "image/pudding-cream"
         case 6:
             return "image/pudding-end"
         case 7:
             return "image/sodacup"
         case 8:
             return "image/soda-ice"
         case 9:
             return "image/soda-soda"
         case 10:
             return "image/soda-float"
         case 11:
             return "image/soda-fin"
         case 12:
             return "image/sodacup"
         case 13:
             return "image/parfeit-cereal"
         case 14:
             return "image/parfeit-ice"
         case 15:
             return "image/parfeit-cream"
         case 16:
             return "image/parfeit-berry"
         case 17:
             return "image/parfeit-fin"
             
         default:
             return "neko"
         }
     }
}

#Preview {
    MainView()
}
