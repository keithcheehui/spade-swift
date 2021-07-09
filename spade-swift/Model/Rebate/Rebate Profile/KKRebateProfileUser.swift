//
//  KKRebateProfileUser.swift
//
//  Created by Wong Sai Khong on 08/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKRebateProfileUser: Codable {

  enum CodingKeys: String, CodingKey {
    case wallet
    case code
    case id
  }

  var wallet: KKRebateProfileWallet?
  var code: String?
  var id: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    wallet = try container.decodeIfPresent(KKRebateProfileWallet.self, forKey: .wallet)
    code = try container.decodeIfPresent(String.self, forKey: .code)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
  }

}
