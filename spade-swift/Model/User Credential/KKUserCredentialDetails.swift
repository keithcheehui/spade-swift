//
//  KKUser.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserCredentialDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case tier
    case walletBalance = "wallet_balance"
    case avatar
    case code
  }

  var tier: KKUserCredentialTierDetails?
  var walletBalance: String?
  var avatar: String?
  var code: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    tier = try container.decodeIfPresent(KKUserCredentialTierDetails.self, forKey: .tier)
    walletBalance = try container.decodeIfPresent(String.self, forKey: .walletBalance)
    avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
    code = try container.decodeIfPresent(String.self, forKey: .code)
  }

}
