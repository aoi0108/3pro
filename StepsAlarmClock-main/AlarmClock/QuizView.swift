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
    
    let csvFileName = "quiz"
    
    var body: some View {
        VStack {
            if !currentQuestion.isEmpty && !answers.isEmpty {
                Text(currentQuestion)
                    .padding(30)
                    .padding(.vertical, 30)
                
                ForEach(0..<min(answers.count, 4), id: \.self) { index in
                    Button(action: {
                        self.selectedAnswerIndex = index
                        self.checkAnswer(selectedIndex: index)
                    }) {
                        Text(self.answers[index])
                            .padding()
                            .frame(maxWidth: 200)
                            .background(self.background(for: index))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    .padding(.vertical, 5)
                }
            }
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
        let csvArray = CSVReader.readCSV(fileName: csvFileName)
        if !csvArray.isEmpty {
            let randomIndex = Int.random(in: 0..<csvArray.count)
            let quizData = csvArray[randomIndex].components(separatedBy: "/")
            
            if quizData.count >= 3 {
                currentQuestion = quizData[0]
                correctAnswerIndex = Int(quizData[1])
                answers = Array(quizData[2..<quizData.count])
            }
        }
    }
    
    private func checkAnswer(selectedIndex: Int) {
        if selectedIndex == correctAnswerIndex {
            correctCount += 1
            isCorrect = true
        } else {
            isCorrect = false
        }
        
        showingScore = true
    }
    
    private func background(for index: Int) -> Color {
        if let selected = selectedAnswerIndex {
            if selected == index && selected == correctAnswerIndex {
                return Color.green
            } else if selected == index {
                return Color.red
            }
        }
        return Color.gray
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(alarmManager: AlarmManager())
    }
}
