//
//  KKDepositDataResponse.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKDepositDataResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case message
    case code
    case error
    case results
  }

  var message: String?
  var code: Int?
  var error: Bool?
  var results: KKDepositDataResults?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    results = try container.decodeIfPresent(KKDepositDataResults.self, forKey: .results)
  }

}
