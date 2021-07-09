//
//  KKRebateTableRebates.swift
//
//  Created by Wong Sai Khong on 09/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKTableRebates: Codable {

  enum CodingKeys: String, CodingKey {
    case rate
    case minAmount = "min_amount"
    case validStake = "valid_stake"
    case maxAmount = "max_amount"
  }

  var rate: String?
  var minAmount: String?
  var validStake: String?
  var maxAmount: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    rate = try container.decodeIfPresent(String.self, forKey: .rate)
    minAmount = try container.decodeIfPresent(String.self, forKey: .minAmount)
    validStake = try container.decodeIfPresent(String.self, forKey: .validStake)
    maxAmount = try container.decodeIfPresent(String.self, forKey: .maxAmount)
  }

}
