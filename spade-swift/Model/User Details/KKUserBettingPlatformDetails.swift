//
//  KKBettingPlatforms.swift
//
//  Created by Keith CheeHui on 18/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserBettingPlatformDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case code
    case groupCode = "group_code"
    case name
  }

  var code: String?
  var groupCode: String?
  var name: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    code = try container.decodeIfPresent(String.self, forKey: .code)
    groupCode = try container.decodeIfPresent(String.self, forKey: .groupCode)
    name = try container.decodeIfPresent(String.self, forKey: .name)
  }

}
