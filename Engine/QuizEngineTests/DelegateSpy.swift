//  Created by Frank Morales on 5/2/23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//

import QuizEngine

class DelegateSpy: QuizDelegate {
    var questionsAsked: [String] = []
    var answerCompletions = [(String) -> Void]()

    var completedQuizzes = [[(String, String)]]()

    func answer(for question: String, completion: @escaping (String) -> Void) {
        questionsAsked.append(question)
        self.answerCompletions.append(completion)
    }

    func didCompleteQuiz(withAnswers answers: [(question: String, answer: String)]) {
        completedQuizzes.append(answers)
    }
}
