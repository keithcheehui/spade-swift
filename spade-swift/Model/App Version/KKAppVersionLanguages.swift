//
//  KKAppVersionLanguages.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAppVersionLanguages: Codable {

  enum CodingKeys: String, CodingKey {
    case locale
    case name
  }

  var locale: String?
  var name: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    locale = try container.decodeIfPresent(String.self, forKey: .locale)
    name = try container.decodeIfPresent(String.self, forKey: .name)
  }

}
