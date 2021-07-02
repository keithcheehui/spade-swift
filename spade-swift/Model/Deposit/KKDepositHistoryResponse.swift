//
//  KKDepositHistoryResponse.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKDepositHistoryResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case code
    case error
    case results
    case message
  }

  var code: Int?
  var error: Bool?
  var results: KKDepositHistoryResults?
  var message: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    results = try container.decodeIfPresent(KKDepositHistoryResults.self, forKey: .results)
    message = try container.decodeIfPresent(String.self, forKey: .message)
  }

}
