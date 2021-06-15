//
//  KKUserProfileTier.swift
//
//  Created by Keith CheeHui on 16/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserProfileTier: Codable {

  enum CodingKeys: String, CodingKey {
    case totalAmountToNextLevel = "total_amount_to_next_level"
    case balance
    case nextLevelName = "next_level_name"
    case currentLevelName = "current_level_name"
  }

  var totalAmountToNextLevel: String?
  var balance: String?
  var nextLevelName: String?
  var currentLevelName: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    totalAmountToNextLevel = try container.decodeIfPresent(String.self, forKey: .totalAmountToNextLevel)
    balance = try container.decodeIfPresent(String.self, forKey: .balance)
    nextLevelName = try container.decodeIfPresent(String.self, forKey: .nextLevelName)
    currentLevelName = try container.decodeIfPresent(String.self, forKey: .currentLevelName)
  }

}
