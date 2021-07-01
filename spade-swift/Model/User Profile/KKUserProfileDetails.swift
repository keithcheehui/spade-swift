//
//  KKUserProfileUser.swift
//
//  Created by Keith CheeHui on 16/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserProfileDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case refCode = "ref_code"
    case username
    case code
    case id
    case name
    case currencyCode = "currency_code"
    case avatarId = "avatar_id"
    case dob
    case email
    case gender
    case tier
    case phoneNo = "phone_no"
    case locale = "locale_preference"
    case walletBalance = "wallet_balance"
    case inboxUnreadMessages = "inbox_unread_messages"
  }

  var refCode: String?
  var username: String?
  var code: String?
  var id: Int?
  var name: String?
  var currencyCode: String?
  var avatarId: Int?
  var dob: String?
  var email: String?
  var gender: String?
  var tier: KKUserProfileTier?
  var phoneNo: String?
  var locale: String?
  var walletBalance: Float?
  var inboxUnreadMessages: Bool?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    refCode = try container.decodeIfPresent(String.self, forKey: .refCode)
    username = try container.decodeIfPresent(String.self, forKey: .username)
    code = try container.decodeIfPresent(String.self, forKey: .code)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    currencyCode = try container.decodeIfPresent(String.self, forKey: .currencyCode)
    avatarId = try container.decodeIfPresent(Int.self, forKey: .avatarId)
    dob = try container.decodeIfPresent(String.self, forKey: .dob)
    email = try container.decodeIfPresent(String.self, forKey: .email)
    gender = try container.decodeIfPresent(String.self, forKey: .gender)
    tier = try container.decodeIfPresent(KKUserProfileTier.self, forKey: .tier)
    phoneNo = try container.decodeIfPresent(String.self, forKey: .phoneNo)
    locale = try container.decodeIfPresent(String.self, forKey: .locale)
    walletBalance = try container.decodeIfPresent(Float.self, forKey: .walletBalance) ?? 0.00
    inboxUnreadMessages = try container.decodeIfPresent(Bool.self, forKey: .inboxUnreadMessages) ?? false
  }
}
