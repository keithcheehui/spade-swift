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
    case filterStatus = "filter_status"
    case history
    case user
  }

    var filterDurations: KKFilterDurations?
    var filterStatus: KKFilterStatus?
  var history: [KKHistoryDetails]?
  var user: KKHeaderUserDetails?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    filterDurations = try container.decodeIfPresent(KKFilterDurations.self, forKey: .filterDurations)
    filterStatus = try container.decodeIfPresent(KKFilterStatus.self, forKey: .filterStatus)
    history = try container.decodeIfPresent([KKHistoryDetails].self, forKey: .history)
    user = try container.decodeIfPresent(KKHeaderUserDetails.self, forKey: .user)
  }

}
