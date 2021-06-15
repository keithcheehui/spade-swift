//
//  KKUserWalletResults.swift
//
//  Created by Keith CheeHui on 16/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserWalletResults: Codable {

  enum CodingKeys: String, CodingKey {
    case walletBalance = "wallet_balance"
  }

  var walletBalance: Float?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    walletBalance = try container.decodeIfPresent(Float.self, forKey: .walletBalance)
  }

}
