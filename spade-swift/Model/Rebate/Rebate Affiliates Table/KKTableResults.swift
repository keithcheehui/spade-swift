//
//  KKRebateTableResults.swift
//
//  Created by Wong Sai Khong on 09/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKTableResults: Codable {

  enum CodingKeys: String, CodingKey {
    case user
    case groups
  }

  var user: KKRebateProfileUser?
  var groups: [KKTableGroups]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    user = try container.decodeIfPresent(KKRebateProfileUser.self, forKey: .user)
    groups = try container.decodeIfPresent([KKTableGroups].self, forKey: .groups)
  }

}
