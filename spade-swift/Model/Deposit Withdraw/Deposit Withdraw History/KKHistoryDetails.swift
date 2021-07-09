//
//  KKDepositHistory.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKHistoryDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case reason
    case status
    case amount
    case trxTimestamp = "trx_timestamp"
    case transactionId = "transaction_id"
  }

    var reason: String?
  var status: String?
  var amount: String?
  var trxTimestamp: String?
  var transactionId: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    reason = try container.decodeIfPresent(String.self, forKey: .reason)
    status = try container.decodeIfPresent(String.self, forKey: .status)
    amount = try container.decodeIfPresent(String.self, forKey: .amount)
    trxTimestamp = try container.decodeIfPresent(String.self, forKey: .trxTimestamp)
    transactionId = try container.decodeIfPresent(Int.self, forKey: .transactionId)
  }

}
