import DeepLCore
import XCTest

import class Foundation.Bundle

final class coreTests: XCTestCase {
  func testExample() throws {
    XCTAssertEqual(DeepL.sample, "sample")
  }

  static var allTests = [
    ("testExample", testExample)
  ]
}
