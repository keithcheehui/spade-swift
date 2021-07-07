//
//  KKAffiliateDownlineResults.swift
//
//  Created by Wong Sai Khong on 08/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateDownlineResults: Codable {

  enum CodingKeys: String, CodingKey {
    case id
    case username
    case totalCommission = "total_commission"
    case totalValidStake = "total_valid_stake"
  }

  var id: String?
  var username: String?
  var totalCommission: Int?
  var totalValidStake: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    username = try container.decodeIfPresent(String.self, forKey: .username)
    totalCommission = try container.decodeIfPresent(Int.self, forKey: .totalCommission)
    totalValidStake = try container.decodeIfPresent(Int.self, forKey: .totalValidStake)
  }

}
