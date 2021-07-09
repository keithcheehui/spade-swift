//
//  KKAffiliateProfileCommission.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateProfileCommission: Codable {

  enum CodingKeys: String, CodingKey {
    case id
    case total
    case turnover
    case available
  }

  var id: Int?
  var total: String?
  var turnover: String?
  var available: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    total = try container.decodeIfPresent(String.self, forKey: .total)
    turnover = try container.decodeIfPresent(String.self, forKey: .turnover)
    available = try container.decodeIfPresent(String.self, forKey: .available)
  }

}
