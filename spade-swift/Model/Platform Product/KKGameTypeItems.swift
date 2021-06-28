//
//  KKGameTypeItems.swift
//
//  Created by Wong Sai Khong on 29/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKGameTypeItems: Codable {

  enum CodingKeys: String, CodingKey {
    case img
    case name
    case type
    case code
  }

  var img: String?
  var name: String?
  var type: String?
  var code: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    img = try container.decodeIfPresent(String.self, forKey: .img)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    code = try container.decodeIfPresent(String.self, forKey: .code)
  }

}
