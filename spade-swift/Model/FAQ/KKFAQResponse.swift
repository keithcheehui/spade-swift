//
//  KKFAQResponse.swift
//
//  Created by Keith CheeHui on 09/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKFAQResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case message
    case code
    case results
    case error
  }

  var message: String?
  var code: Int?
  var results: KKFAQResults?
  var error: Bool?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    results = try container.decodeIfPresent(KKFAQResults.self, forKey: .results)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
  }

}
