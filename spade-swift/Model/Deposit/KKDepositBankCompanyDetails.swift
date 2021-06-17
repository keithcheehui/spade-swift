//
//  KKDepositBankCompanyBanks.swift
//
//  Created by Keith CheeHui on 17/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKDepositBankCompanyDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case bankAccountName = "bank_account_name"
    case bankName = "bank_name"
    case companyBankId = "company_bank_id"
    case bankAccountNumber = "bank_account_number"
  }

  var bankAccountName: String?
  var bankName: String?
  var companyBankId: Int?
  var bankAccountNumber: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    bankAccountName = try container.decodeIfPresent(String.self, forKey: .bankAccountName)
    bankName = try container.decodeIfPresent(String.self, forKey: .bankName)
    companyBankId = try container.decodeIfPresent(Int.self, forKey: .companyBankId)
    bankAccountNumber = try container.decodeIfPresent(String.self, forKey: .bankAccountNumber)
  }

}
