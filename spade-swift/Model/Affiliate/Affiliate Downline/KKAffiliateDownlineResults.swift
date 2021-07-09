//
//  KKAffiliateDownlineResults.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateDownlineResults: Codable {

  enum CodingKeys: String, CodingKey {
    case downlines
    case user
  }

  var downlines: [KKAffiliateDownlineDownlines]?
  var user: KKPageDataUser?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    downlines = try container.decodeIfPresent([KKAffiliateDownlineDownlines].self, forKey: .downlines)
    user = try container.decodeIfPresent(KKPageDataUser.self, forKey: .user)
  }

}
