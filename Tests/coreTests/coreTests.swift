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

  func testParseAPIResult() throws {
    let deepL = DeepL(authKey: "AUTH_KEY")

    let result =
      "{\"translations\":[{\"detected_source_language\":\"JA\",\"text\":\"Good Morning\\n\"}]}"
    let text = try deepL.parseAPIResult(result)

    XCTAssertEqual(text, "Good Morning\n")
  }

  static var allTests = [
    ("testAuthKey", testAuthKey),
    ("testMakePostBodyString", testMakePostBodyString),
    ("testParseAPIResult", testParseAPIResult),
  ]
}
