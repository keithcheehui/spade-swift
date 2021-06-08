//
//  KKSystemMessageResponse.swift
//
//  Created by Keith CheeHui on 09/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKSystemMessageResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case code
    case message
    case results
    case error
  }

  var code: Int?
  var message: String?
  var results: KKSystemMessageResults?
  var error: Bool?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    results = try container.decodeIfPresent(KKSystemMessageResults.self, forKey: .results)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
  }

}
