//
//  KKAffiliateProfileResponse.swift
//
//  Created by Wong Sai Khong on 08/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateProfileResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case message
    case results
    case error
    case code
  }

  var message: String?
  var results: KKAffiliateProfileResults?
  var error: Bool?
  var code: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    results = try container.decodeIfPresent(KKAffiliateProfileResults.self, forKey: .results)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
  }

}
