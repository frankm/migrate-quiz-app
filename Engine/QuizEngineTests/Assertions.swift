//  Created by Frank Morales on 5/2/23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//

import XCTest

func assetEqual(_ a1: [(String, String)], _ a2: [(String, String)], file: StaticString = #filePath, line: UInt = #line) {
    XCTAssertTrue(a1.elementsEqual(a2, by: ==), "\(a1) is not equal to \(a2)", file: file, line: line)
}
