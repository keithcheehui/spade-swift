//
//  KKDepositPageDataUserBankCards.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKPageDataUserBankCards: Codable {

  enum CodingKeys: String, CodingKey {
    case bankMaxWithdrawal = "bank_max_withdrawal"
    case bankMaxDeposit = "bank_max_deposit"
    case bankAccountNumber = "bank_account_number"
    case bankMinDeposit = "bank_min_deposit"
    case bankMinWithdrawal = "bank_min_withdrawal"
    case bankId = "bank_id"
    case bankAccountName = "bank_account_name"
    case id
    case bankName = "bank_name"
    case bankImg = "bank_img"
  }

  var bankMaxWithdrawal: Int?
  var bankMaxDeposit: Int?
  var bankAccountNumber: String?
  var bankMinDeposit: Int?
  var bankMinWithdrawal: Int?
  var bankId: Int?
  var bankAccountName: String?
  var id: Int?
    var bankName: String?
    var bankImg: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    bankMaxWithdrawal = try container.decodeIfPresent(Int.self, forKey: .bankMaxWithdrawal)
    bankMaxDeposit = try container.decodeIfPresent(Int.self, forKey: .bankMaxDeposit)
    bankAccountNumber = try container.decodeIfPresent(String.self, forKey: .bankAccountNumber)
    bankMinDeposit = try container.decodeIfPresent(Int.self, forKey: .bankMinDeposit)
    bankMinWithdrawal = try container.decodeIfPresent(Int.self, forKey: .bankMinWithdrawal)
    bankId = try container.decodeIfPresent(Int.self, forKey: .bankId)
    bankAccountName = try container.decodeIfPresent(String.self, forKey: .bankAccountName)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    bankName = try container.decodeIfPresent(String.self, forKey: .bankName)
    bankImg = try container.decodeIfPresent(String.self, forKey: .bankImg)
  }

}
