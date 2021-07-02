//
//  KKCompanyBanks.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKCompanyBanks: Codable {

  enum CodingKeys: String, CodingKey {
    case bankAccountNumber = "bank_account_number"
    case companyBankId = "company_bank_id"
    case bankName = "bank_name"
    case bankAccountName = "bank_account_name"
  }

  var bankAccountNumber: String?
  var companyBankId: Int?
  var bankName: String?
  var bankAccountName: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    bankAccountNumber = try container.decodeIfPresent(String.self, forKey: .bankAccountNumber)
    companyBankId = try container.decodeIfPresent(Int.self, forKey: .companyBankId)
    bankName = try container.decodeIfPresent(String.self, forKey: .bankName)
    bankAccountName = try container.decodeIfPresent(String.self, forKey: .bankAccountName)
  }

}
