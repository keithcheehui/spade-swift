//
//  KKAffiliateProfileCommission.swift
//
//  Created by Wong Sai Khong on 08/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateProfileCommission: Codable {

  enum CodingKeys: String, CodingKey {
    case available
    case id
    case total
    case turnover
  }

  var available: String?
  var id: Int?
  var total: String?
  var turnover: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    available = try container.decodeIfPresent(String.self, forKey: .available)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    total = try container.decodeIfPresent(String.self, forKey: .total)
    turnover = try container.decodeIfPresent(String.self, forKey: .turnover)
  }

}
