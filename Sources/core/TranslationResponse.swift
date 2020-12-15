//
//  TranslationResponse.swift
//
//  Created by ToKoRo on 2020-12-15.
//

import Foundation

struct TranslationResponse: Decodable {
  let translations: [Translation]

  var resultText: String {
    translations.map(\.text).joined(separator: "\n")
  }
}

// MARK: - Translation

extension TranslationResponse {
  struct Translation: Decodable {
    let detectedSourceLanguage: String
    let text: String
  }
}
