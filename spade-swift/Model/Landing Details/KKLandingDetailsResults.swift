//
//  KKLandingDetailsResults.swift
//
//  Created by Keith CheeHui on 17/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKLandingDetailsResults: Codable {

  enum CodingKeys: String, CodingKey {
    case products
    case userInfo = "user_info"
    case groups
    case announcements
  }

  var products: [KKPlatformProductDetails]?
  var userInfo: KKUserProfileDetails?
  var groups: [KKGroupPlatformGroups]?
  var announcements: [KKAnnouncementDetails]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    products = try container.decodeIfPresent([KKPlatformProductDetails].self, forKey: .products)
    userInfo = try container.decodeIfPresent(KKUserProfileDetails.self, forKey: .userInfo)
    groups = try container.decodeIfPresent([KKGroupPlatformGroups].self, forKey: .groups)
    announcements = try container.decodeIfPresent([KKAnnouncementDetails].self, forKey: .announcements)
  }

}
