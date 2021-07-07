//
//  KKAffiliateCommissionTableRebates.swift
//
//  Created by Wong Sai Khong on 08/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateCommissionTableRebates: Codable {

  enum CodingKeys: String, CodingKey {
    case minAmount = "min_amount"
    case maxAmount = "max_amount"
    case rate
    case validStake = "valid_stake"
  }

  var minAmount: String?
  var maxAmount: String?
  var rate: String?
  var validStake: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    minAmount = try container.decodeIfPresent(String.self, forKey: .minAmount)
    maxAmount = try container.decodeIfPresent(String.self, forKey: .maxAmount)
    rate = try container.decodeIfPresent(String.self, forKey: .rate)
    validStake = try container.decodeIfPresent(String.self, forKey: .validStake)
  }

}
