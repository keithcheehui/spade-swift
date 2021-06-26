//
//  KKUserCountry.swift
//
//  Created by Wong Sai Khong on 27/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserCountry: Codable {

  enum CodingKeys: String, CodingKey {
    case countryName = "country_name"
    case countryImg = "country_img"
  }

  var countryName: String?
  var countryImg: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    countryName = try container.decodeIfPresent(String.self, forKey: .countryName)
    countryImg = try container.decodeIfPresent(String.self, forKey: .countryImg)
  }

}
