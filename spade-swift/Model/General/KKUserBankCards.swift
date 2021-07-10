//
//  KKUserBankCards.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserBankCards: Codable {

  enum CodingKeys: String, CodingKey {
    case bankAccountNumber = "bank_account_number"
    case id
    case bankAccountName = "bank_account_name"
    case bank
  }

  var bankAccountNumber: String?
  var id: Int?
  var bankAccountName: String?
  var bank: KKBankItemDetails?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    bankAccountNumber = try container.decodeIfPresent(String.self, forKey: .bankAccountNumber)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    bankAccountName = try container.decodeIfPresent(String.self, forKey: .bankAccountName)
    bank = try container.decodeIfPresent(KKBankItemDetails.self, forKey: .bank)
  }
}
