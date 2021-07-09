//
//  KKAffiliateDownlineResponse.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateDownlineResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case results
    case message
    case error
    case code
  }

  var results: KKAffiliateDownlineResults?
  var message: String?
  var error: Bool?
  var code: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decodeIfPresent(KKAffiliateDownlineResults.self, forKey: .results)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
  }

}
