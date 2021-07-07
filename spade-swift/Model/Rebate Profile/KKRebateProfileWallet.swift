//
//  KKRebateProfileWallet.swift
//
//  Created by Wong Sai Khong on 08/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKRebateProfileWallet: Codable {

  enum CodingKeys: String, CodingKey {
    case id
    case balance
  }

  var id: Int?
  var balance: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    balance = try container.decodeIfPresent(String.self, forKey: .balance)
  }

}
