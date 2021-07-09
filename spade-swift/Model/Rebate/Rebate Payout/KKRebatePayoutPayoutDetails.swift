//
//  KKRebatePayoutPayoutDetails.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKRebatePayoutPayoutDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case amount
    case validStake = "valid_stake"
    case rate
    case game
    case date
  }

  var amount: String?
  var validStake: String?
  var rate: String?
  var game: String?
  var date: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    amount = try container.decodeIfPresent(String.self, forKey: .amount)
    validStake = try container.decodeIfPresent(String.self, forKey: .validStake)
    rate = try container.decodeIfPresent(String.self, forKey: .rate)
    game = try container.decodeIfPresent(String.self, forKey: .game)
    date = try container.decodeIfPresent(String.self, forKey: .date)
  }

}
