//
//  KKUserProfileTier.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserProfileTier: Codable {

  enum CodingKeys: String, CodingKey {
    case currentLevelImg = "current_level_img"
    case balance
    case nextLevelName = "next_level_name"
    case nextLevelImg = "next_level_img"
    case totalAmountToNextLevel = "total_amount_to_next_level"
    case currentLevelName = "current_level_name"
  }

  var currentLevelImg: String?
  var balance: String?
  var nextLevelName: String?
  var nextLevelImg: String?
  var totalAmountToNextLevel: String?
  var currentLevelName: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    currentLevelImg = try container.decodeIfPresent(String.self, forKey: .currentLevelImg)
    balance = try container.decodeIfPresent(String.self, forKey: .balance)
    nextLevelName = try container.decodeIfPresent(String.self, forKey: .nextLevelName)
    nextLevelImg = try container.decodeIfPresent(String.self, forKey: .nextLevelImg)
    totalAmountToNextLevel = try container.decodeIfPresent(String.self, forKey: .totalAmountToNextLevel)
    currentLevelName = try container.decodeIfPresent(String.self, forKey: .currentLevelName)
  }

}
