//
//  KKBankListOptionResponse.swift
//
//  Created by Wong Sai Khong on 06/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKBankListOptionResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case error
    case message
    case code
    case results
  }

  var error: Bool?
  var message: String?
  var code: Int?
  var results: KKBankListOptionResults?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    results = try container.decodeIfPresent(KKBankListOptionResults.self, forKey: .results)
  }

}
