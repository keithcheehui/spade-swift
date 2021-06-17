//
//  KKBettingResults.swift
//
//  Created by Keith CheeHui on 18/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserBettingResults: Codable {

  enum CodingKeys: String, CodingKey {
    case platforms
    case groups
  }

  var platforms: [KKUserBettingPlatformDetails]?
  var groups: [KKUserBettingGroupDetails]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    platforms = try container.decodeIfPresent([KKUserBettingPlatformDetails].self, forKey: .platforms)
    groups = try container.decodeIfPresent([KKUserBettingGroupDetails].self, forKey: .groups)
  }

}
