//	
// Copyright © 2023 Essential Developer. All rights reserved.
//

import Foundation

final class BigScore {
    static func score(for answers: [String], comparingTo correctAnswers: [String]) -> Int {
        return zip(answers, correctAnswers).reduce(0) { score, tuple in
            return score + (tuple.0 == tuple.1 ? 1 : 0)
        }
    }
}
