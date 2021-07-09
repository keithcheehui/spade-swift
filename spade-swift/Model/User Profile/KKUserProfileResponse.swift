//
//  KKUserProfileResponse.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserProfileResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case results
    case code
    case message
    case error
  }

  var results: KKUserProfileResults?
  var code: Int?
  var message: String?
  var error: Bool?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decodeIfPresent(KKUserProfileResults.self, forKey: .results)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
  }

}
