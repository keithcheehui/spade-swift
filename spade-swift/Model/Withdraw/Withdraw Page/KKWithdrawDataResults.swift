//
//  KKWithdrawDataResults.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKWithdrawDataResults: Codable {

  enum CodingKeys: String, CodingKey {
    case withdrawRange = "withdraw_range"
    case userBankCards = "user_bank_cards"
  }

  var withdrawRange: KKRange?
  var userBankCards: [KKUserBankCards]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    withdrawRange = try container.decodeIfPresent(KKRange.self, forKey: .withdrawRange)
    userBankCards = try container.decodeIfPresent([KKUserBankCards].self, forKey: .userBankCards)
  }

}
