//
//  KKUserCredential.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserCredential: Codable {

  enum CodingKeys: String, CodingKey {
    case status
    case results
    case code
  }

  var status: String?
  var results: KKUserCredentialData?
  var code: Int?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    status = try container.decodeIfPresent(String.self, forKey: .status)
    results = try container.decodeIfPresent(KKUserCredentialData.self, forKey: .results)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
  }

}
