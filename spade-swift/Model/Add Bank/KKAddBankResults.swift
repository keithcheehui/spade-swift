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

  var userBanks: [KKPageDataUserBankCards]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    userBanks = try container.decodeIfPresent([KKPageDataUserBankCards].self, forKey: .userBanks)
  }

}
