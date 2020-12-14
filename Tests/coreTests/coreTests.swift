import DeepLCore
import XCTest

import class Foundation.Bundle

final class coreTests: XCTestCase {
  func testAuthKey() throws {
    let deepL = DeepL(authKey: "SAMPLE")

    XCTAssertEqual(deepL.authKey, "SAMPLE")
  }

  func testMakePostBodyString() throws {
    let deepL = DeepL(authKey: "AUTH_KEY")
    let postBodyString = deepL.makePostBodyString(
      text: "abc\"D",
      sourceLang: "JA",
      targetLang: "DE"
    )

    XCTAssertEqual(postBodyString, "auth_key=AUTH_KEY&text=abc%22D&target_lang=DE&source_lang=JA")
  }

  static var allTests = [
    ("testAuthKey", testAuthKey)
  ]
}
