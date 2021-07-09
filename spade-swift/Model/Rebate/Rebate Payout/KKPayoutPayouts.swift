//
//  KKRebatePayoutPayouts.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKPayoutPayouts: Codable {

  enum CodingKeys: String, CodingKey {
    case rebateAmount = "rebate_amount"
    case commissionAmount = "commission_amount"
    case payoutDetails = "payout_details"
    case rate
    case validStake = "valid_stake"
    case date
  }

    var rebateAmount: String?
    var commissionAmount: String?
  var payoutDetails: [KKRebatePayoutPayoutDetails]?
  var rate: String?
  var validStake: String?
  var date: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    rebateAmount = try container.decodeIfPresent(String.self, forKey: .rebateAmount)
    commissionAmount = try container.decodeIfPresent(String.self, forKey: .commissionAmount)
    payoutDetails = try container.decodeIfPresent([KKRebatePayoutPayoutDetails].self, forKey: .payoutDetails)
    rate = try container.decodeIfPresent(String.self, forKey: .rate)
    validStake = try container.decodeIfPresent(String.self, forKey: .validStake)
    date = try container.decodeIfPresent(String.self, forKey: .date)
  }

}
