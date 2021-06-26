//
//  KKLandingDetailsResults.swift
//
//  Created by Keith CheeHui on 17/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKLandingDetailsResults: Codable {

    var userCountry: KKUserCountry?
    var userInfo: KKUserProfileDetails?
    var groups: [KKGroupPlatformGroups]?
    var announcements: [KKAnnouncementDetails]?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    userCountry = try container.decodeIfPresent(KKUserCountry.self, forKey: .userCountry)
    userInfo = try container.decodeIfPresent(KKUserProfileDetails.self, forKey: .userInfo)
    groups = try container.decodeIfPresent([KKGroupPlatformGroups].self, forKey: .groups)
    announcements = try container.decodeIfPresent([KKAnnouncementDetails].self, forKey: .announcements)
  }
}
