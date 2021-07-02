//
//  KKDepositRange.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKRange: Codable {

  enum CodingKeys: String, CodingKey {
    case max
    case min
  }

  var max: Int?
  var min: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    max = try container.decodeIfPresent(Int.self, forKey: .max)
    min = try container.decodeIfPresent(Int.self, forKey: .min)
  }

}
