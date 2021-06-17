//
//  KKDepositHistoryResults.swift
//
//  Created by Keith CheeHui on 17/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKDepositHistoryResults: Codable {

  enum CodingKeys: String, CodingKey {
    case depositHistory = "deposit_history"
  }

  var depositHistory: [KKDepositHistoryDetails]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    depositHistory = try container.decodeIfPresent([KKDepositHistoryDetails].self, forKey: .depositHistory)
  }

}
