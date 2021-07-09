//
//  KKPageDataResponse.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKPageDataResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case code
    case message
    case error
    case results
  }

  var code: Int?
  var message: String?
  var error: Bool?
  var results: KKPageDataResults?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    results = try container.decodeIfPresent(KKPageDataResults.self, forKey: .results)
  }

}
