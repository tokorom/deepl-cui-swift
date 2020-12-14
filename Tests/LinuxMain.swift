import XCTest

import coreTests

var tests = [XCTestCaseEntry]()
tests += coreTests.allTests()
XCTMain(tests)
