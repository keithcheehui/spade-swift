//
//  KKUserBettingHistoryBetslips.swift
//
//  Created by Keith CheeHui on 18/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserBettingHistoryDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case betslipId = "betslip_id"
    case platformId = "platform_id"
    case stake
    case validStake = "valid_stake"
    case gameName = "game_name"
    case result
    case amount
    case trxTimestamp = "trx_timestamp"
  }

    var betslipId: Int?
    var platformId: Int?
    var stake: String?
    var validStake: String?
    var gameName: String?
    var result: String?
    var amount: String?
    var trxTimestamp: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    betslipId = try container.decodeIfPresent(Int.self, forKey: .betslipId)
    platformId = try container.decodeIfPresent(Int.self, forKey: .platformId)
    stake = try container.decodeIfPresent(String.self, forKey: .stake)
    validStake = try container.decodeIfPresent(String.self, forKey: .validStake)
    gameName = try container.decodeIfPresent(String.self, forKey: .gameName)
    amount = try container.decodeIfPresent(String.self, forKey: .amount)
    result = try container.decodeIfPresent(String.self, forKey: .result)
    trxTimestamp = try container.decodeIfPresent(String.self, forKey: .trxTimestamp)
  }

}
