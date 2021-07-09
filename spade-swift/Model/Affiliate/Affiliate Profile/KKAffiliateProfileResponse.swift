//
//  KKAffiliateProfileResponse.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateProfileResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case message
    case error
    case code
    case results
  }

  var message: String?
  var error: Bool?
  var code: Int?
  var results: KKAffiliateProfileResults?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    results = try container.decodeIfPresent(KKAffiliateProfileResults.self, forKey: .results)
  }

}
