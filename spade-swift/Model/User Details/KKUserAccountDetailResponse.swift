//
//  KKUserAccountDetailResponse.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserAccountDetailResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case message
    case code
    case results
    case error
  }

  var message: String?
  var code: Int?
  var results: KKUserAccountDetailResults?
  var error: Bool?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    results = try container.decodeIfPresent(KKUserAccountDetailResults.self, forKey: .results)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
  }

}
