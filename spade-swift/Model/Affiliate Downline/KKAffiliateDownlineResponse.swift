//
//  KKAffiliateDownlineResponse.swift
//
//  Created by Wong Sai Khong on 08/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateDownlineResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case error
    case results
    case code
    case message
  }

  var error: Bool?
  var results: [KKAffiliateDownlineResults]?
  var code: Int?
  var message: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    results = try container.decodeIfPresent([KKAffiliateDownlineResults].self, forKey: .results)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    message = try container.decodeIfPresent(String.self, forKey: .message)
  }

}
