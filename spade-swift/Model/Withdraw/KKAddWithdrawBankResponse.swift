//
//  KKAddWithdrawBankResponse.swift
//
//  Created by Keith CheeHui on 17/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAddWithdrawBankResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case results
    case error
    case code
    case message
  }

  var results: KKAddWithdrawBankResults?
  var error: Bool?
  var code: Int?
  var message: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decodeIfPresent(KKAddWithdrawBankResults.self, forKey: .results)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    message = try container.decodeIfPresent(String.self, forKey: .message)
  }

}
