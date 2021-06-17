//
//  KKWithdrawHistoryResults.swift
//
//  Created by Keith CheeHui on 17/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKWithdrawHistoryResults: Codable {

  enum CodingKeys: String, CodingKey {
    case withdrawHistory = "withdraw_history"
  }

  var withdrawHistory: [KKWithdrawHistoryDetails]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    withdrawHistory = try container.decodeIfPresent([KKWithdrawHistoryDetails].self, forKey: .withdrawHistory)
  }

}
