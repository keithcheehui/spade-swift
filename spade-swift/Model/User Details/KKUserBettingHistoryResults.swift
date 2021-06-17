//
//  KKUserBettingHistoryResults.swift
//
//  Created by Keith CheeHui on 18/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserBettingHistoryResults: Codable {

  enum CodingKeys: String, CodingKey {
    case betslips
  }

  var betslips: [KKUserBettingHistoryDetails]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    betslips = try container.decodeIfPresent([KKUserBettingHistoryDetails].self, forKey: .betslips)
  }

}
