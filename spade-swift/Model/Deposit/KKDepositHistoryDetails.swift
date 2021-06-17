//
//  KKDepositHistoryDetails.swift
//
//  Created by Keith CheeHui on 17/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKDepositHistoryDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case paymentMethod = "payment_method"
    case refNo = "ref_no"
    case status
    case amount
    case type
    case trxTimestamp = "trx_timestamp"
  }

  var paymentMethod: String?
  var refNo: String?
  var status: String?
  var amount: String?
  var type: String?
  var trxTimestamp: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    paymentMethod = try container.decodeIfPresent(String.self, forKey: .paymentMethod)
    refNo = try container.decodeIfPresent(String.self, forKey: .refNo)
    status = try container.decodeIfPresent(String.self, forKey: .status)
    amount = try container.decodeIfPresent(String.self, forKey: .amount)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    trxTimestamp = try container.decodeIfPresent(String.self, forKey: .trxTimestamp)
  }

}
