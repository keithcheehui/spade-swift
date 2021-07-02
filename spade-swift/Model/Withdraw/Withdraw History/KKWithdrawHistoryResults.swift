//
//  KKWithdrawHistoryResults.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKWithdrawHistoryResults: Codable {

  enum CodingKeys: String, CodingKey {
    case withdrawHistory = "withdraw_history"
  }

  var withdrawHistory: [KKHistoryDetails]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    withdrawHistory = try container.decodeIfPresent([KKHistoryDetails].self, forKey: .withdrawHistory)
  }

}
