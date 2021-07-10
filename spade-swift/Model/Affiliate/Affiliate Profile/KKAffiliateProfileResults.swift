//
//  KKAffiliateProfileResults.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateProfileResults: Codable {

  enum CodingKeys: String, CodingKey {
    case affiliate
    case user
  }

  var affiliate: KKAffiliateProfileAffiliate?
  var user: KKHeaderUserDetails?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    affiliate = try container.decodeIfPresent(KKAffiliateProfileAffiliate.self, forKey: .affiliate)
    user = try container.decodeIfPresent(KKHeaderUserDetails.self, forKey: .user)
  }

}
