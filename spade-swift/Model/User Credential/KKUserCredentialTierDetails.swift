//
//  KKTier.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserCredentialTierDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case name
    case balance
  }

  var name: String?
  var balance: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    balance = try container.decodeIfPresent(String.self, forKey: .balance)
  }

}
