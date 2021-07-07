//
//  KKAffiliateProfileResults.swift
//
//  Created by Wong Sai Khong on 08/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateProfileResults: Codable {

  enum CodingKeys: String, CodingKey {
    case user
  }

  var user: KKAffiliateProfileUser?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    user = try container.decodeIfPresent(KKAffiliateProfileUser.self, forKey: .user)
  }

}
