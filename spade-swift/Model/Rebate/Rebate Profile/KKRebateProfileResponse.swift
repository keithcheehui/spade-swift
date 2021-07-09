//
//  KKRebateProfileResponse.swift
//
//  Created by Wong Sai Khong on 08/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKRebateProfileResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case error
    case message
    case results
    case code
  }

  var error: Bool?
  var message: String?
  var results: KKRebateProfileResults?
  var code: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    results = try container.decodeIfPresent(KKRebateProfileResults.self, forKey: .results)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
  }

}
