//
//  KKUserProfileAllTiers.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserProfileAllTiers: Codable {

  enum CodingKeys: String, CodingKey {
    case img
    case descriptionValue = "description"
    case nextLvlPoints = "next_lvl_points"
    case name
    case level
    case id
  }

  var img: String?
  var descriptionValue: String?
  var nextLvlPoints: String?
  var name: String?
  var level: Int?
  var id: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    img = try container.decodeIfPresent(String.self, forKey: .img)
    descriptionValue = try container.decodeIfPresent(String.self, forKey: .descriptionValue)
    nextLvlPoints = try container.decodeIfPresent(String.self, forKey: .nextLvlPoints)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    level = try container.decodeIfPresent(Int.self, forKey: .level)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
  }

}
