//
//  KKUserBettingHistoryBetslips.swift
//
//  Created by Keith CheeHui on 18/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserBettingHistoryDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case refNo = "ref_no"
    case stake
    case gameName = "game_name"
    case result
    case trxTimestamp = "trx_timestamp"
  }

  var refNo: String?
  var stake: String?
  var gameName: String?
  var result: String?
  var trxTimestamp: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    refNo = try container.decodeIfPresent(String.self, forKey: .refNo)
    stake = try container.decodeIfPresent(String.self, forKey: .stake)
    gameName = try container.decodeIfPresent(String.self, forKey: .gameName)
    result = try container.decodeIfPresent(String.self, forKey: .result)
    trxTimestamp = try container.decodeIfPresent(String.self, forKey: .trxTimestamp)
  }

}
