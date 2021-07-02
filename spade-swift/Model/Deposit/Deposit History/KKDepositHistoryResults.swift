//
//  KKResults.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKDepositHistoryResults: Codable {

  enum CodingKeys: String, CodingKey {
    case depositHistory = "deposit_history"
  }

  var depositHistory: [KKHistoryDetails]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    depositHistory = try container.decodeIfPresent([KKHistoryDetails].self, forKey: .depositHistory)
  }

}
