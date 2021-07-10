//
//  KKHistoryResults.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKHistoryResults: Codable {

  enum CodingKeys: String, CodingKey {
    case history
    case filterStatus = "filter_status"
    case filterDurations = "filter_durations"
    case user
  }

    var history: [KKHistoryDetails]?
  var filterStatus: KKFilterStatus?
  var filterDurations: KKFilterDurations?
  var user: KKHeaderUserDetails?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    history = try container.decodeIfPresent([KKHistoryDetails].self, forKey: .history)
    filterStatus = try container.decodeIfPresent(KKFilterStatus.self, forKey: .filterStatus)
    filterDurations = try container.decodeIfPresent(KKFilterDurations.self, forKey: .filterDurations)
    user = try container.decodeIfPresent(KKHeaderUserDetails.self, forKey: .user)
  }

}
