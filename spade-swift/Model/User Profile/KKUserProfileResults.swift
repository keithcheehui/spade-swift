//
//  KKUserProfileResults.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserProfileResults: Codable {

  enum CodingKeys: String, CodingKey {
    case user
    case allTiers = "all_tiers"
  }

  var user: KKUserProfileDetails?
  var allTiers: [KKUserProfileAllTiers]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    user = try container.decodeIfPresent(KKUserProfileDetails.self, forKey: .user)
    allTiers = try container.decodeIfPresent([KKUserProfileAllTiers].self, forKey: .allTiers)
  }

}
