//  Created by Frank Morales on 5/1/23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//

import XCTest
import QuizEngine

class QuizTest: XCTestCase {

    private var quiz: Quiz!

    func test_startQuiz_answerAllQuestions_completesWithAnswers() {
        let delegate = DelegateSpy()

        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate)

        delegate.answerCompletions[0]("A1")
        delegate.answerCompletions[1]("A2")

        XCTAssertEqual(delegate.completedQuizzes.count, 1)
        assetEqual(delegate.completedQuizzes[0], [("Q1", "A1"), ("Q2", "A2")])
    }

    private func assetEqual(_ a1: [(String, String)], _ a2: [(String, String)], file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(a1.elementsEqual(a2, by: ==), "\(a1) is not equal to \(a2)", file: file, line: line)
    }

    private class DelegateSpy: QuizDelegate {
        var completedQuizzes = [[(String, String)]]()

        var answerCompletions = [(String) -> Void]()

        func answer(for question: String, completion: @escaping (String) -> Void) {
            self.answerCompletions.append(completion)
        }

        func didCompleteQuiz(withAnswers answers: [(question: String, answer: String)]) {
            completedQuizzes.append(answers)
        }

        func handle(result: Result<String, String>) { }
    }

}
