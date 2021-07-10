//
//  KKRebateTransResults.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKTransactionResults: Codable {

  enum CodingKeys: String, CodingKey {
    case user
    case filterDurations = "filter_durations"
    case type
    case rebateTransactions = "rebate_transactions"
    case commissionTransactions = "commission_transactions"
  }

  var user: KKHeaderUserDetails?
  var filterDurations: KKFilterDurations?
  var type: KKFilterType?
    var rebateTransactions: [KKTransactionTransactions]?
    var commissionTransactions: [KKTransactionTransactions]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    user = try container.decodeIfPresent(KKHeaderUserDetails.self, forKey: .user)
    filterDurations = try container.decodeIfPresent(KKFilterDurations.self, forKey: .filterDurations)
    type = try container.decodeIfPresent(KKFilterType.self, forKey: .type)
    rebateTransactions = try container.decodeIfPresent([KKTransactionTransactions].self, forKey: .rebateTransactions)
    commissionTransactions = try container.decodeIfPresent([KKTransactionTransactions].self, forKey: .commissionTransactions)
  }

}
