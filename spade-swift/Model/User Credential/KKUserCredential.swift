//
//  KKUserCredential.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserCredential: Codable {

  enum CodingKeys: String, CodingKey {
    case message
    case results
    case error
    case code
  }

  var message: String?
  var results: KKUserCredentialData?
  var error: Bool?
  var code: Int?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    results = try container.decodeIfPresent(KKUserCredentialData.self, forKey: .results)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
  }

}
