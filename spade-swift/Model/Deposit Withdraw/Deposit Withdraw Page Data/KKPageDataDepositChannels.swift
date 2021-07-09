//
//  KKPageDataDepositChannels.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKPageDataDepositChannels: Codable {

  enum CodingKeys: String, CodingKey {
    case max
    case code
    case name
    case min
  }

  var max: String?
  var code: String?
  var name: String?
  var min: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    max = try container.decodeIfPresent(String.self, forKey: .max)
    code = try container.decodeIfPresent(String.self, forKey: .code)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    min = try container.decodeIfPresent(String.self, forKey: .min)
  }

}
