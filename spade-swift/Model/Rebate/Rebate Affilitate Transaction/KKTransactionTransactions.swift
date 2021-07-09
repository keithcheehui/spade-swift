//
//  KKRebateTransRebateTransactions.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKTransactionTransactions: Codable {

  enum CodingKeys: String, CodingKey {
    case trxDate = "trx_date"
    case code
    case type
    case amount
  }

  var trxDate: String?
  var code: String?
  var type: String?
  var amount: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    trxDate = try container.decodeIfPresent(String.self, forKey: .trxDate)
    code = try container.decodeIfPresent(String.self, forKey: .code)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    amount = try container.decodeIfPresent(String.self, forKey: .amount)
  }

}
