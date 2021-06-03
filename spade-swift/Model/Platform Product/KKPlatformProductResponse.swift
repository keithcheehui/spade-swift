//
//  KKPlatformProductResponse.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKPlatformProductResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case results
    case code
    case message
    case error
  }

  var results: KKPlatformProductResults?
  var code: Int?
  var message: String?
  var error: Bool?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decodeIfPresent(KKPlatformProductResults.self, forKey: .results)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
  }

}
