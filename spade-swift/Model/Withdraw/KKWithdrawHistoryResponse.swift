//
//  KKWithdrawHistoryResponse.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKWithdrawHistoryResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case code
    case results
    case error
    case message
  }

  var code: Int?
  var results: KKWithdrawHistoryResults?
  var error: Bool?
  var message: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    results = try container.decodeIfPresent(KKWithdrawHistoryResults.self, forKey: .results)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    message = try container.decodeIfPresent(String.self, forKey: .message)
  }

}
