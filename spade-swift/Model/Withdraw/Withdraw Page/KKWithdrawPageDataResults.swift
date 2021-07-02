//
//  KKWithdrawDataResults.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKWithdrawPageDataResults: Codable {

  enum CodingKeys: String, CodingKey {
    case userBankCards = "user_bank_cards"
  }

  var userBankCards: [KKPageDataUserBankCards]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    userBankCards = try container.decodeIfPresent([KKPageDataUserBankCards].self, forKey: .userBankCards)
  }

}
