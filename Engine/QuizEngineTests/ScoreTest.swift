//  Created by Frank Morales on 5/3/23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//

import XCTest

class ScoreTest: XCTestCase {
    func test_noAnswers_scoresZero() {
        XCTAssertEqual(BigScore.score(for: [], comparingTo: []), 0)
    }

    func test_oneWrongAnswer_scoresZero() {
        XCTAssertEqual(BigScore.score(for: ["wrong"], comparingTo: ["correct"]), 0)
    }

    func test_oneCorrectAnswer_scoresOne() {
        XCTAssertEqual(BigScore.score(for: ["correct"], comparingTo: ["correct"]), 1)
    }

    func test_oneCorrectAnswerOneWrongAnswer_scoresOne() {
        let score = BigScore.score(for: ["correct", "wrong"], comparingTo: ["correct", "correct"])
        XCTAssertEqual(score, 1)
    }

    private class BigScore {
        static func score(for answers: [String], comparingTo correctAnswers: [String]) -> Int {
            var score = 0
            for (index, answer) in answers.enumerated() {
                score += (answer == correctAnswers[index] ? 1 : 0)
            }
            return score
        }
    }
}
