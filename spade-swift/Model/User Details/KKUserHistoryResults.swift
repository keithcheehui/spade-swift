//
//  KKUserHistoryResults.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserHistoryResults: Codable {

  enum CodingKeys: String, CodingKey {
    case filterDurations = "filter_durations"
    case history
    case user
  }

  var filterDurations: KKPageDataFilterDurations?
  var history: [KKHistoryDetails]?
  var user: KKPageDataUser?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    filterDurations = try container.decodeIfPresent(KKPageDataFilterDurations.self, forKey: .filterDurations)
    history = try container.decodeIfPresent([KKHistoryDetails].self, forKey: .history)
    user = try container.decodeIfPresent(KKPageDataUser.self, forKey: .user)
  }

}
