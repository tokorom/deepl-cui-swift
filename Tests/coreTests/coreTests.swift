import DeepLCore
import XCTest

import class Foundation.Bundle

final class coreTests: XCTestCase {
  func testAuthKey() throws {
    let deepL = DeepL(authKey: "SAMPLE")

    XCTAssertEqual(deepL.authKey, "SAMPLE")
  }

  static var allTests = [
    ("testAuthKey", testAuthKey)
  ]
}
