//
//  Copyright © 2017 Essential Developer. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
	
    func test_start_withNoQuestions_doesNotDelegateToQuestionHandling() {
        makeSUT(questions: []).start()
        
        XCTAssertTrue(delegate.handledQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_delegatesToCorrectQuestionHandling() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1"])
    }

    func test_start_withOneQuestion_delegatesToAnotherCorrectQuestionHandling() {
        makeSUT(questions: ["Q2"]).start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_delegatesToFirstQuestionHandling() {
        makeSUT(questions: ["Q1", "Q2"]).start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1"])
    }

    func test_startTwice_withTwoQuestions_delegatesToFirstQuestionHandlingTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1", "Q1"])
    }

    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_delegatesToSecondAndThirdQuestionHandling() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")

        XCTAssertEqual(delegate.handledQuestions, ["Q1", "Q2", "Q3"])
    }

    func test_startAndAnswerFirstQuestion_withOneQuestion_doesNotDelegateToAnotherQuestionHandling() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        
        delegate.answerCallback("A1")
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1"])
    }
    
    func test_start_withNoQuestions_delegatesToResultHandling() {
        makeSUT(questions: []).start()
        
        XCTAssertEqual(delegate.handledResult!.answers, [:])
    }
    
    func test_start_withOneQuestions_doesNotDelegateToResultHandling() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertNil(delegate.handledResult)
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_doesNotDelegateToResultHandling() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        delegate.answerCallback("A1")
        
        XCTAssertNil(delegate.handledResult)
    }

    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_delegatesToResultHandling() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        
        XCTAssertEqual(delegate.handledResult!.answers, ["Q1": "A1", "Q2": "A2"])
    }

    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_scores() {
        let sut = makeSUT(questions: ["Q1", "Q2"], scoring: { _ in 10 })
        sut.start()
        
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        
        XCTAssertEqual(delegate.handledResult!.score, 10)
    }

    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_scoresWithRightAnswers() {
        var receivedAnswers = [String: String]()
        let sut = makeSUT(questions: ["Q1", "Q2"], scoring: { answers in
            receivedAnswers = answers
            return 20
        })
        sut.start()
        
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        
        XCTAssertEqual(receivedAnswers, ["Q1": "A1", "Q2": "A2"])
    }


    // MARK: Helpers
	
	private let delegate = DelegateSpy()
	
	private weak var weakSUT: Flow<DelegateSpy>?
	
	override func tearDown() {
		super.tearDown()
		
		XCTAssertNil(weakSUT, "Memory leak detected. Weak reference to the SUT instance is not nil.")
	}
	
    private func makeSUT(questions: [String],
                 scoring: @escaping ([String: String]) -> Int = { _ in 0 }) -> Flow<DelegateSpy> {
        let sut = Flow(questions: questions, router: delegate, scoring: scoring)
		weakSUT = sut
		return sut
    }

    private class DelegateSpy: Router, QuizDelegate {
        var handledQuestions: [String] = []
        var handledResult: Result<String, String>? = nil

        var answerCallback: (String) -> Void = { _ in }

        func handle(question: String, answerCallback: @escaping (String) -> Void) {
            handledQuestions.append(question)
            self.answerCallback = answerCallback
        }

        func handle(result: Result<String, String>) {
            handledResult = result

        }
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            handle(question: question, answerCallback: answerCallback)
        }

        func routeTo(result: Result<String, String>) {
            handle(result: result)
        }
    }

}
