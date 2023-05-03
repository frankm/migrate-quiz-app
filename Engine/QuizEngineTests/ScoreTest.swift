//  Created by Frank Morales on 5/3/23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//

import XCTest

class ScoreTest: XCTestCase {
    func test_noAnswers_scoresZero() {
        XCTAssertEqual(BigScore.score(for: [], comparingTo: []), 0)
    }

    func test_oneNonMatchingAnswer_scoresZero() {
        XCTAssertEqual(BigScore.score(for: ["not a match"], comparingTo: ["an answer"]), 0)
    }

    func test_oneMatchingAnswer_scoresOne() {
        XCTAssertEqual(BigScore.score(for: ["an answer"], comparingTo: ["an answer"]), 1)
    }

    func test_oneMatchingAnswerOneNonMatchingAnswer_scoresOne() {
        let score = BigScore.score(
            for: ["an answer", "not a match"],
            comparingTo: ["an answer", "another answer"])
        XCTAssertEqual(score, 1)
    }

    func test_twoMatchingAnswers_scoresTwo() {
        let score = BigScore.score(
            for: ["an answer", "an answer"],
            comparingTo: ["an answer", "an answer"])
        XCTAssertEqual(score, 2)
    }

    func test_withTooManyAnswers_twoMatchingAnswers_scoresTwo() {
        let score = BigScore.score(
            for: ["an answer", "another answer", "an extra answer"],
            comparingTo: ["an answer", "another answer"])
        XCTAssertEqual(score, 2)
    }

    private class BigScore {
        static func score(for answers: [String], comparingTo correctAnswers: [String]) -> Int {
            var score = 0
            for (index, answer) in answers.enumerated() {
                if index >= correctAnswers.count { return  score }
                score += (answer == correctAnswers[index] ? 1 : 0)
            }
            return score
        }
    }
}
