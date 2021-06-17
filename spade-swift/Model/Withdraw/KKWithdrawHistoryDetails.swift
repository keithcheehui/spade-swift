//
//  KKWithdrawHistoryWithdrawHistory.swift
//
//  Created by Keith CheeHui on 17/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKWithdrawHistoryDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case trxTimestamp = "trx_timestamp"
    case withdrawalMethod = "withdrawal_method"
    case status
    case withdrawCode = "withdraw_code"
    case amount
    case userBankId = "user_bank_id"
  }

  var trxTimestamp: String?
  var withdrawalMethod: String?
  var status: String?
  var withdrawCode: String?
  var amount: String?
  var userBankId: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    trxTimestamp = try container.decodeIfPresent(String.self, forKey: .trxTimestamp)
    withdrawalMethod = try container.decodeIfPresent(String.self, forKey: .withdrawalMethod)
    status = try container.decodeIfPresent(String.self, forKey: .status)
    withdrawCode = try container.decodeIfPresent(String.self, forKey: .withdrawCode)
    amount = try container.decodeIfPresent(String.self, forKey: .amount)
    userBankId = try container.decodeIfPresent(Int.self, forKey: .userBankId)
  }

}
