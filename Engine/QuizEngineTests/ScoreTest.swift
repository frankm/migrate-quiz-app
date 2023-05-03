//  Created by Frank Morales on 5/3/23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//

import XCTest

class ScoreTest: XCTestCase {
    func test_noAnswers_scoresZero() {
        XCTAssertEqual(BigScore.score(for: []), 0)
    }

    private class BigScore {
        static func score(for: [Any]) -> Int {
            return 0
        }
    }
}
