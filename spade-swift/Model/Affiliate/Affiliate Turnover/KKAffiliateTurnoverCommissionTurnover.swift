//
//  KKAffiliateTurnoverCommissionTurnover.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateTurnoverCommissionTurnover: Codable {

  enum CodingKeys: String, CodingKey {
    case validStake = "valid_stake"
    case userId = "user_id"
    case commission
    case username
    case code
  }

  var validStake: String?
  var userId: Int?
  var commission: String?
  var username: String?
  var code: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    validStake = try container.decodeIfPresent(String.self, forKey: .validStake)
    userId = try container.decodeIfPresent(Int.self, forKey: .userId)
    commission = try container.decodeIfPresent(String.self, forKey: .commission)
    username = try container.decodeIfPresent(String.self, forKey: .username)
    code = try container.decodeIfPresent(String.self, forKey: .code)
  }

}
