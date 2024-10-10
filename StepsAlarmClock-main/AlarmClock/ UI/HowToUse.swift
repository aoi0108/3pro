//
//  HowToUse.swift
//  AlarmClock
//
//  Created by 平松蒼惟 on 2024/09/12.
//

import SwiftUI

struct HowToUse: View{
    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        ScrollView{
            VStack (alignment: .leading, spacing: 40){
                Text("使い方")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("brown"))
                    .padding()
                
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("beige"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 240)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("1.  ホーム画面中央の時計ボタンでアラームを設定する。")
                        Text("2. 設定した時間になるとアラームが鳴り、問題が出題される。")
                        Text("3. 問題に正解すると、アラームが止まり、アイテムを獲得できる。")
                        Text("4. 集めたアイテムはホーム画面右側のコレクションボタンで閲覧できる。")
                    }
                    .padding()
                    .foregroundColor(.black)
                }
                
                .padding([.leading, .trailing], 20)
            }
            
            
//            VStack (alignment: .leading, spacing: 20){
//                Text("How to Play")
//                    .font(.largeTitle)
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color("brown"))
//                    .padding()
//                   
//                ZStack{
//                    RoundedRectangle(cornerRadius: 15)
//                        .fill(Color("beige"))
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 240)
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("1. Set an alarm by tapping the clock button in the center of the home screen.")
//                        Text("2. When the set time arrives, the alarm will ring and a question will be presented.")
//                        Text("3. Answer the question correctly to stop the alarm and earn an item.")
//                        Text("4. You can view the collected items by tapping the collection button on the right side of the home screen.")
//                    }
//                    .padding()
//                    .foregroundColor(.black)
//                }
//                .padding([.leading, .trailing], 20)
//            }
            .padding(.bottom, 20)
           
        }
        

     
        
    }
       
}


#Preview {
    HowToUse()
}
