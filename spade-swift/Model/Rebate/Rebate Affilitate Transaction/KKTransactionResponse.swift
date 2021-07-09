//
//  KKRebateTransResponse.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKTransactionResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case message
    case results
    case code
    case error
  }

  var message: String?
  var results: KKTransactionResults?
  var code: Int?
  var error: Bool?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    results = try container.decodeIfPresent(KKTransactionResults.self, forKey: .results)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
  }

}
