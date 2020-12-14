//
//  DeepL.swift
//
//  Created by ToKoRo on 2020-12-14.
//

import Foundation

public final class DeepL {
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
    DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
      completion(.success(text))
    }
  }
}
