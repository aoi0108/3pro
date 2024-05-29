import SwiftUI

struct QuizView: View {
    @State private var quizCount = 0
    @AppStorage("score") var correctCount = 0
    @State private var quizArray: [String] = []
    @State private var showingScore = false
    @State private var selectedAnswerIndex: Int?
    @State public var correct : Bool
    @ObservedObject var alarmManager: AlarmManager
    
    let csvArray: [String] = [
        " John Smith, a well-respected entrepreneur, _______ his latest venture at the conference last week./2/launching/ launched/launch/to launch/",
    ]
    
    var body: some View {
        VStack {
            if !quizArray.isEmpty {
                Text(quizArray[0])
                    .padding(30)
                    .padding(.vertical, 30)
                
                ForEach(2 ..< quizArray.count - 1, id: \.self) { index in
                    Button(action: {
                        self.selectedAnswerIndex = index
                        self.checkAnswer(selectedIndex: index)
                    }) {
                        Text(self.quizArray[index])
                               .padding()
                               .frame(maxWidth:200)
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
        .sheet(isPresented: $showingScore) {
            ScoreView(correctCount: self.correctCount, alarmManager: alarmManager, correct: $correct)
        }
    }
    
    private func loadQuiz() {
        if quizCount < csvArray.count {
            quizArray = csvArray[quizCount].components(separatedBy: "/")
        }
    }
    
    private func checkAnswer(selectedIndex: Int) {
        if selectedIndex - 1 == Int(quizArray[1]) {
            correctCount += 1
            correct = true
        }
        
        quizCount += 1
        
        if quizCount < csvArray.count {
            loadQuiz()
        } else {
            showingScore = true
        }
    }
    
    private func background(for index: Int) -> Color {
        if let selected = selectedAnswerIndex {
            if selected == index && selected - 1 == Int(quizArray[1]) {
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
        @State var correct = true
                ScoreView(correctCount: 0, alarmManager: AlarmManager(), correct: $correct)
            }
    }

