//
//  KKUserProfileAllTiers.swift
//
//  Created by Keith CheeHui on 16/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserProfileAllTiers: Codable {

  enum CodingKeys: String, CodingKey {
    case nextLvlPoints = "next_lvl_points"
    case lpConversionBirthday = "lp_conversion_birthday"
    case id
    case name
    case lpConversion = "lp_conversion"
    case tpConversion = "tp_conversion"
    case descriptionValue = "description"
    case level
    case tpConversionBirthday = "tp_conversion_birthday"
  }

  var nextLvlPoints: String?
  var lpConversionBirthday: String?
  var id: Int?
  var name: String?
  var lpConversion: String?
  var tpConversion: String?
  var descriptionValue: String?
  var level: Int?
  var tpConversionBirthday: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    nextLvlPoints = try container.decodeIfPresent(String.self, forKey: .nextLvlPoints)
    lpConversionBirthday = try container.decodeIfPresent(String.self, forKey: .lpConversionBirthday)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    lpConversion = try container.decodeIfPresent(String.self, forKey: .lpConversion)
    tpConversion = try container.decodeIfPresent(String.self, forKey: .tpConversion)
    descriptionValue = try container.decodeIfPresent(String.self, forKey: .descriptionValue)
    level = try container.decodeIfPresent(Int.self, forKey: .level)
    tpConversionBirthday = try container.decodeIfPresent(String.self, forKey: .tpConversionBirthday)
  }

}
