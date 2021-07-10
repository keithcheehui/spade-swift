//
//  KKVipResults.swift
//
//  Created by Wong Sai Khong on 11/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKVipResults: Codable {

  enum CodingKeys: String, CodingKey {
    case detail
    case img
    case isCurrentLevel
  }

  var detail: [KKVipDetail]?
  var img: String?
  var isCurrentLevel: Bool?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    detail = try container.decodeIfPresent([KKVipDetail].self, forKey: .detail)
    img = try container.decodeIfPresent(String.self, forKey: .img)
    isCurrentLevel = try container.decodeIfPresent(Bool.self, forKey: .isCurrentLevel)
  }

}
