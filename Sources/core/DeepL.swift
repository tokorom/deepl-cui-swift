//
//  DeepL.swift
//
//  Created by ToKoRo on 2020-12-14.
//

import Foundation

public final class DeepL {
  private static let translateAPIURL = URL(string: "https://api-free.deepl.com/v2/translate")!
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
    let request = makeRequest(text: text, sourceLang: sourceLang, targetLang: targetLang)

    let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }

      guard let data = data, data.count > 0 else {
        fatalError("API response is empty.")
      }

      guard let result = String(data: data, encoding: .utf8) else {
        fatalError("API response is invalid.")
      }

      let resultText: String
      do {
        resultText = try self.parseAPIResult(result)
      } catch {
        completion(.failure(error))
        return
      }

      completion(.success(resultText))
    }
    dataTask.resume()
  }

  public func makeRequest(
    text: String,
    sourceLang: String?,
    targetLang: String
  ) -> URLRequest {
    var request = URLRequest(url: Self.translateAPIURL)
    request.httpMethod = "POST"
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

    let postBodyString = makePostBodyString(
      text: text,
      sourceLang: sourceLang,
      targetLang: targetLang
    )
    guard let postData = postBodyString.data(using: .utf8) else {
      fatalError("Invalid post data.")
    }

    request.httpBody = postData

    return request
  }

  public func makePostBodyString(
    text: String,
    sourceLang: String?,
    targetLang: String
  ) -> String {
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

    return String(queryItemsString.suffix(queryItemsString.count - 1))
  }

  public func parseAPIResult(_ result: String) throws -> String {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let data = result.data(using: .utf8) ?? Data()
    let translationResponse = try decoder.decode(TranslationResponse.self, from: data)
    return translationResponse.resultText
  }
}
