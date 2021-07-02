//
//  KKUserBankCards.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserBankCards: Codable {

  enum CodingKeys: String, CodingKey {
    case bankAccountNumber = "bank_account_number"
    case bankName = "bank_name"
    case bankAccountName = "bank_account_name"
    case bankId = "bank_id"
    case id
    case bankImg = "bank_img"
  }

  var bankAccountNumber: String?
  var bankName: String?
  var bankAccountName: String?
  var bankId: Int?
  var id: Int?
    var bankImg: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    bankAccountNumber = try container.decodeIfPresent(String.self, forKey: .bankAccountNumber)
    bankName = try container.decodeIfPresent(String.self, forKey: .bankName)
    bankAccountName = try container.decodeIfPresent(String.self, forKey: .bankAccountName)
    bankId = try container.decodeIfPresent(Int.self, forKey: .bankId)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    bankImg = try container.decodeIfPresent(String.self, forKey: .bankImg)
  }

}
