//
//  KKOTPRequestData.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKOTPRequestData: Codable {

  enum CodingKeys: String, CodingKey {
    case expiredAt = "expired_at"
    case phoneNumber = "phone_number"
  }

  var expiredAt: String?
  var phoneNumber: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    expiredAt = try container.decodeIfPresent(String.self, forKey: .expiredAt)
    phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
  }

}
