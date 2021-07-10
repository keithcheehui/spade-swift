//
//  KKResults.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAddBankResults: Codable {

  enum CodingKeys: String, CodingKey {
    case userBanks = "user_banks"
  }

  var userBanks: [KKUserBankCards]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    userBanks = try container.decodeIfPresent([KKUserBankCards].self, forKey: .userBanks)
  }

}
