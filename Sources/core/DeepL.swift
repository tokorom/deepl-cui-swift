//
//  DeepL.swift
//
//  Created by ToKoRo on 2020-12-14.
//

import Foundation

public final class DeepL {
  private static let translateAPIURL = URL(string: "https://api.deepl.com/v2/translate")!
  public let authKey: String

  public init(authKey: String) {
    self.authKey = authKey
  }

  public func translate(
    text: String,
    sourceLang: String? = nil,
    targetLang: String,
    completion: @escaping (Result<String, Error>) -> Void
  ) {
    var request = URLRequest(url: Self.translateAPIURL)
    request.httpMethod = "POST"
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

    let authKeyItem = URLQueryItem(name: "auth_key", value: authKey)
    let textItem = URLQueryItem(name: "text", value: text)
    let targetLangItem = URLQueryItem(name: "target_lang", value: targetLang)
    let sourceLangItem: URLQueryItem?
    if let sourceLang = sourceLang {
      sourceLangItem = URLQueryItem(name: "source_lang", value: sourceLang)
    } else {
      sourceLangItem = nil
    }

    var comp = URLComponents()
    comp.queryItems = [authKeyItem, textItem, targetLangItem, sourceLangItem].compactMap { $0 }

    guard let queryItemsString = comp.string else {
      fatalError("Invalid arguments.")
    }

    guard let postData = String(queryItemsString.suffix(1)).data(using: .utf8) else {
      fatalError("Invalid post data.")
    }

    request.httpBody = postData

    let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }

      guard let data = data, data.count > 0 else {
        fatalError("API response is empty.")
      }

      guard let resultText = String(data: data, encoding: .utf8) else {
        fatalError("API response is invalid.")
      }

      completion(.success(resultText))
    }
    dataTask.resume()
  }
}
