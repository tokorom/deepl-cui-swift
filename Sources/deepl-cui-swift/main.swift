import ArgumentParser
import DeepLCore
import Foundation

struct Command: ParsableCommand {
  static let envNameDeepLAuthKey = "DEEPL_AUTH_KEY"

  @Argument(help: "Text to be translated. If not specified, use STDIN.")
  var text: String?

  @Option(
    name: .shortAndLong,
    help:
      "Language of the text to be translated. If this parameter is omitted, the API will attempt to detect the language of the text and translate it."
  )
  var sourceLang: String?

  @Option(name: .shortAndLong, help: "The language into which the text should be translated")
  var targetLang: String = "EN-US"

  @Flag(name: .shortAndLong, help: "Include pre-translated text in output results")
  var withSource: Bool = false

  @Option(
    name: .long,
    help: "authKey for DeepL API. If not specified, use the environment variable DEEPL_AUTH_KEY."
  )
  var authKey: String?

  mutating func run() throws {
    let group = DispatchGroup()
    group.enter()

    let authKey: String

    if let validAuthKey = self.authKey {
      authKey = validAuthKey
    } else if let validAuthKey = ProcessInfo.processInfo.environment[Self.envNameDeepLAuthKey] {
      authKey = validAuthKey
    } else {
      fatalError("\(Self.envNameDeepLAuthKey) is not found.")
    }

    let text: String

    if let validText = self.text {
      text = validText
    } else {
      let standardInput = FileHandle.standardInput
      text = String(data: standardInput.availableData, encoding: .utf8) ?? ""
    }

    let deepL = DeepL(authKey: authKey)
    let withSource = self.withSource

    deepL.translate(text: text, sourceLang: sourceLang, targetLang: targetLang) { result in
      let resultText = (try? result.get()) ?? ""
      let outputText: String
      if withSource {
        outputText = text + resultText
      } else {
        outputText = resultText
      }

      if let data = outputText.data(using: .utf8) {
        let standardOutput = FileHandle.standardOutput
        standardOutput.write(data)
      }
      group.leave()
    }

    group.wait()
  }
}

Command.main()
