//
//  KKGroupPlatformResponse.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKGroupPlatformResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case message
    case error
    case code
    case results
  }

  var message: String?
  var error: Bool?
  var code: Int?
  var results: KKGroupPlatformResults?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    results = try container.decodeIfPresent(KKGroupPlatformResults.self, forKey: .results)
  }

}
