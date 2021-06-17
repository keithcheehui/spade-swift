//
//  KKAddWithdrawBankResults.swift
//
//  Created by Keith CheeHui on 17/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAddWithdrawBankResults: Codable {

  enum CodingKeys: String, CodingKey {
    case userBanks = "user_banks"
  }

  var userBanks: [KKWithdrawBankDetails]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    userBanks = try container.decodeIfPresent([KKWithdrawBankDetails].self, forKey: .userBanks)
  }

}
