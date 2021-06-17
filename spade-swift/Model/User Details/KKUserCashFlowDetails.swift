//
//  KKUserCashflowCashflows.swift
//
//  Created by Keith CheeHui on 18/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserCashFlowDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case amount
    case balance
    case trxTimestamp = "trx_timestamp"
    case type
  }

  var amount: String?
  var balance: Float?
  var trxTimestamp: String?
  var type: String?

    

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    amount = try container.decodeIfPresent(String.self, forKey: .amount)
    balance = try container.decodeIfPresent(Float.self, forKey: .balance)
    trxTimestamp = try container.decodeIfPresent(String.self, forKey: .trxTimestamp)
    type = try container.decodeIfPresent(String.self, forKey: .type)
  }

}
