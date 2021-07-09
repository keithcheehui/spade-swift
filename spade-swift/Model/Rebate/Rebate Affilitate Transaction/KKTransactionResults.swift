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

  var user: KKPageDataUser?
  var filterDurations: KKPageDataFilterDurations?
  var type: KKTransactionType?
    var rebateTransactions: [KKTransactionTransactions]?
    var commissionTransactions: [KKTransactionTransactions]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    user = try container.decodeIfPresent(KKPageDataUser.self, forKey: .user)
    filterDurations = try container.decodeIfPresent(KKPageDataFilterDurations.self, forKey: .filterDurations)
    type = try container.decodeIfPresent(KKTransactionType.self, forKey: .type)
    rebateTransactions = try container.decodeIfPresent([KKTransactionTransactions].self, forKey: .rebateTransactions)
    commissionTransactions = try container.decodeIfPresent([KKTransactionTransactions].self, forKey: .commissionTransactions)
  }

}
