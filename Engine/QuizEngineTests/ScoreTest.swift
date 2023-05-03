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

    private class BigScore {
        static func score(for answers: [String], comparingTo correctAnswers: [String]) -> Int {
            if answers.isEmpty { return 0 }
            return answers == correctAnswers ? 1 : 0
        }
    }
}
