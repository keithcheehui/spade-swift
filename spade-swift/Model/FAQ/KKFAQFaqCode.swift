//
//  KKFAQFaqCode.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKFAQFaqCode: Codable {

  enum CodingKeys: String, CodingKey {
    case general = "GENERAL"
    case deposit = "DEPOSIT"
    case withdrawal = "WITHDRAWAL"
    case affiliate = "AFFILIATE"
  }

  var general: String?
  var deposit: String?
  var withdrawal: String?
  var affiliate: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    general = try container.decodeIfPresent(String.self, forKey: .general)
    deposit = try container.decodeIfPresent(String.self, forKey: .deposit)
    withdrawal = try container.decodeIfPresent(String.self, forKey: .withdrawal)
    affiliate = try container.decodeIfPresent(String.self, forKey: .affiliate)
  }

}
