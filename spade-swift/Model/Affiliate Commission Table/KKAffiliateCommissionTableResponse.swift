//
//  KKAffiliateCommissionTableResponse.swift
//
//  Created by Wong Sai Khong on 08/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateCommissionTableResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case error
    case code
    case message
    case results
  }

  var error: Bool?
  var code: Int?
  var message: String?
  var results: [KKAffiliateCommissionTableResults]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    results = try container.decodeIfPresent([KKAffiliateCommissionTableResults].self, forKey: .results)
  }

}
