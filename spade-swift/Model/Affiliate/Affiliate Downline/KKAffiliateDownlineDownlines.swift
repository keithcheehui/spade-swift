//
//  KKAffiliateDownlineDownlines.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateDownlineDownlines: Codable {

  enum CodingKeys: String, CodingKey {
    case totalCommission = "total_commission"
    case username
    case totalValidStake = "total_valid_stake"
    case code
  }

  var totalCommission: String?
  var username: String?
  var totalValidStake: String?
  var code: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    totalCommission = try container.decodeIfPresent(String.self, forKey: .totalCommission)
    username = try container.decodeIfPresent(String.self, forKey: .username)
    totalValidStake = try container.decodeIfPresent(String.self, forKey: .totalValidStake)
    code = try container.decodeIfPresent(String.self, forKey: .code)
  }

}
