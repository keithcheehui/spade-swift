//
//  KKGameTypeListing.swift
//
//  Created by Wong Sai Khong on 29/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKGameTypeListing: Codable {

  enum CodingKeys: String, CodingKey {
    case gameTypeItems = "game_type_items"
    case name
    case type
    case img2
    case code
  }

  var gameTypeItems: [KKGameTypeItems]?
  var name: String?
  var type: String?
  var img2: String?
  var code: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    gameTypeItems = try container.decodeIfPresent([KKGameTypeItems].self, forKey: .gameTypeItems)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    img2 = try container.decodeIfPresent(String.self, forKey: .img2)
    code = try container.decodeIfPresent(String.self, forKey: .code)
  }

}
