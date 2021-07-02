//
//  KKDepositPageDataDepositChannels.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKDepositPageDataDepositChannels: Codable {

  enum CodingKeys: String, CodingKey {
    case name
    case max
    case min
    case code
  }

  var name: String?
  var max: String?
  var min: String?
  var code: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    max = try container.decodeIfPresent(String.self, forKey: .max)
    min = try container.decodeIfPresent(String.self, forKey: .min)
    code = try container.decodeIfPresent(String.self, forKey: .code)
  }

}
