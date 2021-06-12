//
//  KKBonusResponse.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 12/06/2021.
//

import Foundation
struct KKBonusResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case message
    case code
    case results
    case error
  }

  var message: String?
  var code: Int?
  var results: KKBonusResults?
  var error: Bool?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    results = try container.decodeIfPresent(KKBonusResults.self, forKey: .results)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
  }

}
