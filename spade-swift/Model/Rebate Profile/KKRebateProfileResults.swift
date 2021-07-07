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
  }

  var user: KKRebateProfileUser?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    user = try container.decodeIfPresent(KKRebateProfileUser.self, forKey: .user)
  }

}
