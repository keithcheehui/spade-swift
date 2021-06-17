//
//  KKWithdrawBankUserBanks.swift
//
//  Created by Keith CheeHui on 17/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKWithdrawBankDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case bankAccountName = "bank_account_name"
    case bankId = "bank_id"
    case bankName = "bank_name"
    case bankAccountNumber = "bank_account_number"
  }

  var bankAccountName: String?
  var bankId: Int?
  var bankName: String?
  var bankAccountNumber: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    bankAccountName = try container.decodeIfPresent(String.self, forKey: .bankAccountName)
    bankId = try container.decodeIfPresent(Int.self, forKey: .bankId)
    bankName = try container.decodeIfPresent(String.self, forKey: .bankName)
    bankAccountNumber = try container.decodeIfPresent(String.self, forKey: .bankAccountNumber)
  }

}
