//
//  KKAffiliateTurnoverResults.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateTurnoverResults: Codable {

  enum CodingKeys: String, CodingKey {
    case filterDurations = "filter_durations"
    case user
    case commissionTurnover = "commission_turnover"
  }

  var filterDurations: KKPageDataFilterDurations?
  var user: KKPageDataUser?
  var commissionTurnover: [KKAffiliateTurnoverCommissionTurnover]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    filterDurations = try container.decodeIfPresent(KKPageDataFilterDurations.self, forKey: .filterDurations)
    user = try container.decodeIfPresent(KKPageDataUser.self, forKey: .user)
    commissionTurnover = try container.decodeIfPresent([KKAffiliateTurnoverCommissionTurnover].self, forKey: .commissionTurnover)
  }

}
