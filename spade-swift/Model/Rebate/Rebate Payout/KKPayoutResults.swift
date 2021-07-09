//
//  KKRebatePayoutResults.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKPayoutResults: Codable {

  enum CodingKeys: String, CodingKey {
    case group
    case user
    case filterDurations = "filter_durations"
  }

  var group: [KKPayoutGroup]?
  var user: KKPageDataUser?
  var filterDurations: KKPageDataFilterDurations?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    group = try container.decodeIfPresent([KKPayoutGroup].self, forKey: .group)
    user = try container.decodeIfPresent(KKPageDataUser.self, forKey: .user)
    filterDurations = try container.decodeIfPresent(KKPageDataFilterDurations.self, forKey: .filterDurations)
  }

}
