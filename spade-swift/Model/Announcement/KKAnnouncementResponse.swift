//
//  KKAnnouncementResponse.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAnnouncementResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case error
    case message
    case results
    case code
  }

  var error: Bool?
  var message: String?
  var results: KKAnnouncementResults?
  var code: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    error = try container.decodeIfPresent(Bool.self, forKey: .error)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    results = try container.decodeIfPresent(KKAnnouncementResults.self, forKey: .results)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
  }

}
