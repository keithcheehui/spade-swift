//
//  KKDepositBankResponse.swift
//
//  Created by Keith CheeHui on 17/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKDepositBankResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case message
    case error
    case results
    case code
  }

  var message: String?
  var error: Bool?
  var results: KKDepositBankResults?
  var code: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    results = try container.decodeIfPresent(KKDepositBankResults.self, forKey: .results)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
  }

}
