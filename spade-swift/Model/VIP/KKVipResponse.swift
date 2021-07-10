//
//  KKVipResponse.swift
//
//  Created by Wong Sai Khong on 11/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKVipResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case results
    case error
    case message
    case code
  }

  var results: [KKVipResults]?
  var error: Bool?
  var message: String?
  var code: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decodeIfPresent([KKVipResults].self, forKey: .results)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
  }

}
