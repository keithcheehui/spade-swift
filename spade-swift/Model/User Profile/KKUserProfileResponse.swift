//
//  KKUserProfileResponse.swift
//
//  Created by Keith CheeHui on 16/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserProfileResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case error
    case code
    case message
    case results
  }

  var error: Bool?
  var code: Int?
  var message: String?
  var results: KKUserProfileResults?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    results = try container.decodeIfPresent(KKUserProfileResults.self, forKey: .results)
  }

}
