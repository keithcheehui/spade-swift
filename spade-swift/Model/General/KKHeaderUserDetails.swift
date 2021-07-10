//
//  KKHeaderUserDetails.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKHeaderUserDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case id
    case wallet
    case code
  }

  var id: Int?
  var wallet: KKHeaderWallet?
  var code: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    wallet = try container.decodeIfPresent(KKHeaderWallet.self, forKey: .wallet)
    code = try container.decodeIfPresent(String.self, forKey: .code)
  }

}
