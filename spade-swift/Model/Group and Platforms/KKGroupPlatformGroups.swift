//
//  KKGroupPlatformGroups.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKGroupPlatformGroups: Codable {

  enum CodingKeys: String, CodingKey {
    case descriptionValue = "description"
    case name
    case platforms = "group_items"
    case code
    case img
  }

  var descriptionValue: String?
  var name: String?
  var platforms: [KKGroupPlatformDetails]?
  var code: String?
  var img: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    descriptionValue = try container.decodeIfPresent(String.self, forKey: .descriptionValue)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    platforms = try container.decodeIfPresent([KKGroupPlatformDetails].self, forKey: .platforms)
    code = try container.decodeIfPresent(String.self, forKey: .code)
    img = try container.decodeIfPresent(String.self, forKey: .img)
  }

}
