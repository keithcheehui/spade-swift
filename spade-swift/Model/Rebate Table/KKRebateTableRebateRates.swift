//
//  KKRebateTableRebateRates.swift
//
//  Created by Wong Sai Khong on 06/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKRebateTableRebateRates: Codable {

  enum CodingKeys: String, CodingKey {
    case validStake = "valid_stake"
    case rate
  }

  var validStake: String?
  var rate: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    validStake = try container.decodeIfPresent(String.self, forKey: .validStake)
    rate = try container.decodeIfPresent(String.self, forKey: .rate)
  }

}
