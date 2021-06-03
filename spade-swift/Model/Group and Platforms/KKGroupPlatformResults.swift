//
//  KKGroupPlatformResults.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKGroupPlatformResults: Codable {

  enum CodingKeys: String, CodingKey {
    case groups
  }

  var groups: [KKGroupPlatformGroups]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    groups = try container.decodeIfPresent([KKGroupPlatformGroups].self, forKey: .groups)
  }

}
