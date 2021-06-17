//
//  KKWithdrawBankResults.swift
//
//  Created by Keith CheeHui on 17/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKWithdrawBankResults: Codable {

  enum CodingKeys: String, CodingKey {
    case bankNames = "bank_names"
    case userBanks = "user_banks"
  }

  var bankNames: [KKWithdrawBankNames]?
  var userBanks: [KKWithdrawBankDetails]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    bankNames = try container.decodeIfPresent([KKWithdrawBankNames].self, forKey: .bankNames)
    userBanks = try container.decodeIfPresent([KKWithdrawBankDetails].self, forKey: .userBanks)
  }

}
