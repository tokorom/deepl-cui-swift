import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(deepl_cui_swiftTests.allTests),
    ]
}
#endif
