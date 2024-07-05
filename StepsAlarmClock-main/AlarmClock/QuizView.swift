import SwiftUI

struct QuizView: View {
    @State private var quizCount = 0
    @AppStorage("score") var correctCount = 0
    @State private var quizArray: [String] = []
    @State private var showingScore = false
    @State private var selectedAnswerIndex: Int?
    @ObservedObject var alarmManager: AlarmManager
    @State var isCorrect = false
    
    let csvArray: [String] = [
        "John Smith, a well-respected entrepreneur, _______ his latest venture at the conference last week./2/launching/launched/launch/to launch/",
        "The new project was _______ by the team yesterday./1/start/started/starting/to start/",
        "Mary _______ the book to her friend last week./2/give/gave/giving/to give/",
        "The weather _______ very nice yesterday./1/is/was/are/to be/",
        "The meeting will _______ at 3 PM tomorrow./2/start/started/starting/to start/",
        "The report _______ by the manager last Monday./2/write/wrote/writing/written/",
        "She _______ a beautiful song at the concert last night./1/sing/sang/singing/sung/",
        "The new software _______ by the developers last month./2/create/created/creating/to create/",
        "They _______ a new policy for the company last week./2/announce/announced/announcing/to announce/",
        "The car _______ at the dealership yesterday./2/buy/bought/buying/to buy/"
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
        .sheet(isPresented: $showingScore) {
            ScoreView(correctCount: self.correctCount, alarmManager: alarmManager, isCorrect: self.isCorrect)
        }
    }
    
    private func loadQuiz() {
        if !csvArray.isEmpty {
            let randomIndex = Int.random(in: 0..<csvArray.count)
            quizArray = csvArray[randomIndex].components(separatedBy: "/")
        }
    }
    
    private func checkAnswer(selectedIndex: Int) {
        if selectedIndex - 1 == Int(quizArray[1]) {
            correctCount += 1
            isCorrect = true
        } else {
            isCorrect = false
        }
        
        showingScore = true
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
        QuizView(alarmManager: AlarmManager())
    }
}
