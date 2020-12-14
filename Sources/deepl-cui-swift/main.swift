import Foundation
import DeepLCore


let text: String = "こんにちは"
let sourceLang: String? = nil
let targetLang: String = "EN-US"

let deepL = DeepL(authKey: "SAMPLE")

let group = DispatchGroup()
group.enter()

deepL.translate(text: text, sourceLang: sourceLang, targetLang: targetLang) { result in
  print(result)
  group.leave()
}

group.wait()
