//
//  KKAffiliateTurnoverResponse.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateTurnoverResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case error
    case code
    case results
    case message
  }

  var error: Bool?
  var code: Int?
  var results: KKAffiliateTurnoverResults?
  var message: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    results = try container.decodeIfPresent(KKAffiliateTurnoverResults.self, forKey: .results)
    message = try container.decodeIfPresent(String.self, forKey: .message)
  }

}
