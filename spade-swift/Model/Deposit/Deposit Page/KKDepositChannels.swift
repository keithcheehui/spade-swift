//
//  KKDepositChannels.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKDepositChannels: Codable {

  enum CodingKeys: String, CodingKey {
    case name
    case min
    case code
    case max
  }

  var name: String?
  var min: String?
  var code: String?
  var max: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    min = try container.decodeIfPresent(String.self, forKey: .min)
    code = try container.decodeIfPresent(String.self, forKey: .code)
    max = try container.decodeIfPresent(String.self, forKey: .max)
  }

}
