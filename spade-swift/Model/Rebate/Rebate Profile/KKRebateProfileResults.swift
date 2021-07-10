//
//  KKRebateProfileResults.swift
//
//  Created by Wong Sai Khong on 08/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKRebateProfileResults: Codable {

  enum CodingKeys: String, CodingKey {
    case user
    case rebate
  }

    var user: KKHeaderUserDetails?
    var rebate: KKRebateProfileRebate?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    user = try container.decodeIfPresent(KKHeaderUserDetails.self, forKey: .user)
    rebate = try container.decodeIfPresent(KKRebateProfileRebate.self, forKey: .rebate)
  }

}
