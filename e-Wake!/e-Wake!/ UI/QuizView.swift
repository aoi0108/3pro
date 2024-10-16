import SwiftUI

struct QuizView: View {
    @State private var quizCount = 0
    @AppStorage("score") var correctCount = 0
    @State private var currentQuestion: String = ""
    @State private var answers: [String] = []
    @State private var correctAnswerIndex: Int?
    @State private var showingScore = false
    @State private var selectedAnswerIndex: Int?
    @ObservedObject var alarmManager: AlarmManager
    @State var isCorrect = false
    @State private var navigateToMainView = false
    @ObservedObject var viewModel: MainViewModel
    let csvFileName = "quiz"
    
    var body: some View {
        VStack {
            Spacer()

            if !currentQuestion.isEmpty && !answers.isEmpty {
                VStack(spacing: 20) {
                    Spacer()

                    // クイズタイトル
                    Text("Today's Quiz")
                        .font(.title)
                        .foregroundColor(Color("brown"))
                        .bold()
               // 質問部分
                    Text(currentQuestion)
                        .font(.system(size: 20))
                        .foregroundColor(Color("brown"))
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color("beige").opacity(0.5))
                        )
                      
                    
                        .padding(.horizontal, 30)
                        .padding()
                    Spacer()

                }
                
                Spacer()
                // 選択肢のボタン表示
                ForEach(0..<min(answers.count, 4), id: \.self) { index in
                    Button(action: {
                        self.selectedAnswerIndex = index
                        self.checkAnswer(selectedIndex: index)
                        print("index:\(index)")
                    }) {
                        Text(self.answers[index])
                            .font(.system(size: 20))
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(self.background(for: index))
                            .foregroundColor(Color("brown"))
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color("brown"), lineWidth: 2)
                            )

                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    
                }
            }
            Spacer()
        }
        .padding(.vertical, 20)
        .background(Color("lightBackground")) // 背景色を追加してクイズ画面らしさを演出
        .onAppear {
            self.loadQuiz()
        }

        .onAppear {
            self.loadQuiz()
        }
        .sheet(isPresented: $showingScore, onDismiss: {
            if isCorrect {
                navigateToMainView = true
            }
        }) {
            ScoreView(correctCount: self.correctCount, alarmManager: alarmManager, isCorrect: self.isCorrect)
        }
        
        NavigationLink(
            destination: MainView(),
            isActive: $navigateToMainView,
            label: { EmptyView() }
        )
        
    }
    
    private func loadQuiz() {
        /*
         
         年、月、日を使ってインデックスを決定 (例えば、年 * 月 * 日の合計を使用)
         <2024/10/13に実行し、quiz.csvにあるクイズ数が54個の場合>
         2024 * 10 * 13 / 53 = 4964 あまり28
         よりクイズのindex番号が28のクイズが出題される
         
         */
        let csvArray = CSVReader.readCSV(fileName: csvFileName)
        
        if !csvArray.isEmpty {
            // 現在の日付を取得
            let today = Date()
            let calendar = Calendar.current
            
            let year = calendar.component(.year, from: today)
            let month = calendar.component(.month, from: today)
            let day = calendar.component(.day, from: today)
            
            let index = (year * month * day) % csvArray.count
            
            let quizData = csvArray[index].components(separatedBy: "/")
            
            if quizData.count >= 3 {
                currentQuestion = quizData[0]
                correctAnswerIndex = Int(quizData[1])
                answers = Array(quizData[2..<quizData.count])
            }
        }
    }
    
    
    private func checkAnswer(selectedIndex: Int) {
        if selectedIndex == correctAnswerIndex {
            // MainViewModelのcorrectCountを更新
            viewModel.correctCount += 1
            isCorrect = true
            // コレクションを更新
            viewModel.updateCollection()
            print("あなたの回答: selectedIndex \(selectedIndex)")
            print("正解: correctAnswerIndex \(correctAnswerIndex ?? -1)")
            print("現在のcorrectCount: \(viewModel.correctCount)")
        } else {
            isCorrect = false
        }
        showingScore = true
    }
    
    private func background(for index: Int) -> Color {
        if let selected = selectedAnswerIndex {
            if selected == index && selected == correctAnswerIndex {
                return Color("green").opacity(0.7)
            } else if selected == index {
                return Color("red").opacity(0.7)
            }
        }
        return Color("beige").opacity(0.5)
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(alarmManager: AlarmManager(), viewModel: MainViewModel())
    }
}
