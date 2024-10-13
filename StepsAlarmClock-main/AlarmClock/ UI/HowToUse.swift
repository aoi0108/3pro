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
        NavigationStack {
            ScrollView{
                VStack (alignment: .leading, spacing: 20){

                    Text("使い方")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("brown"))
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("beige"))
                            .frame(maxWidth: .infinity)
                            .frame(height: 240)
                        VStack(alignment: .leading, spacing: 10) {
                            Text("1. ホーム画面中央の時計ボタンでアラームを設定する。")
                            Text("2. 設定した時間になるとアラームが鳴り、問題が出題される。")
                            Text("3. 問題に正解すると、アラームが止まり、アイテムを獲得できる。")
                            Text("4. 集めたアイテムはホーム画面右側のコレクションボタンで閲覧できる。")
                        }
                        .padding()
                        .foregroundColor(.brown)
                    
                    }
                    
                    Text("制作者情報")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("brown"))
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("beige"))
                            .frame(maxWidth: .infinity)
                           
                        VStack(alignment: .leading, spacing: 10) {
                            Text("津田塾大学 学芸学部 情報科学科")
                            Text("2024年度 3年プロジェクト制作物")
                            Text("研究室：栗原研究室")
                            Text("制作者：平松蒼惟 羽田野真央")
                            Link("GitHub URL：aoi0108/3pro", destination: URL(string: "https://github.com/aoi0108/3pro")!)
                            
                        }.padding()
                        .foregroundColor(.brown)
                    
                    }
                    Text("クレジット")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("brown"))
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("beige"))
                            .frame(maxWidth: .infinity)
                        VStack(alignment: .leading){
                            Link("GitHub URL：sekibouya/StepsAlarmClock", destination: URL(string: "https://github.com/sekibouya/StepsAlarmClock.git")!)
                            Text("BGM by OtoLogic(CC BY 4.0)")
                           
                        }
                        .padding()
                        .foregroundColor(.brown)
                    
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                            ToolbarItem(placement: .principal) {
                                VStack {
                                    Spacer()
                                    Text("Info")
                                        .foregroundColor(Color("brown"))
                                        .font(.title)
                                        .bold()
                                   
                                }
                            }
                        }
        }
            .padding(.bottom, 20)
        }
    }

#Preview {
    HowToUse()
}
