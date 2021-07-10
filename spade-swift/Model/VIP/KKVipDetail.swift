//
//  KKVipDetail.swift
//
//  Created by Wong Sai Khong on 11/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKVipDetail: Codable {

  enum CodingKeys: String, CodingKey {
    case value
    case label
  }

  var value: String?
  var label: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    value = try container.decodeIfPresent(String.self, forKey: .value)
    label = try container.decodeIfPresent(String.self, forKey: .label)
  }

}
