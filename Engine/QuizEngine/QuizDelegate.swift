//  Created by Frank Morales on 5/1/23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//

import Foundation

public protocol QuizDelegate {
    associatedtype Question
    associatedtype Answer

    func answer(for question: Question, completion: @escaping (Answer) -> Void)

    func didCompleteQuiz(withAnswers: [(question: Question, answer: Answer)])
}
