//
//  KKBettingGroups.swift
//
//  Created by Keith CheeHui on 18/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserBettingGroupDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case code
    case descriptionValue = "description"
    case name
  }

  var code: String?
  var descriptionValue: String?
  var name: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    code = try container.decodeIfPresent(String.self, forKey: .code)
    descriptionValue = try container.decodeIfPresent(String.self, forKey: .descriptionValue)
    name = try container.decodeIfPresent(String.self, forKey: .name)
  }

}
