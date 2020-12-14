import ArgumentParser
import DeepLCore
import Foundation

struct Command: ParsableCommand {
  @Argument(help: "Text to be translated.")
  var text: String?

  @Option(name: .shortAndLong, help: "Language of the text to be translated.")
  var sourceLang: String?

  @Option(name: .shortAndLong, help: "The language into which the text should be translated.")
  var targetLang: String = "EN-US"

  mutating func run() throws {
    let deepL = DeepL(authKey: "SAMPLE")

    let group = DispatchGroup()
    group.enter()

    let text: String

    if let validText = self.text {
      text = validText
    } else {
      let standardInput = FileHandle.standardInput
      text = String(data: standardInput.availableData, encoding: .utf8) ?? ""
    }

    deepL.translate(text: text, sourceLang: sourceLang, targetLang: targetLang) { result in
      print(result)
      group.leave()
    }

    group.wait()
  }
}

Command.main()
