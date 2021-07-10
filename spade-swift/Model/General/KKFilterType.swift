//
//  KKFilterType.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKFilterType: Codable {

  enum CodingKeys: String, CodingKey {
    case collect = "COLLECT"
    case payout = "PAYOUT"
  }

  var collect: String?
  var payout: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    collect = try container.decodeIfPresent(String.self, forKey: .collect)
    payout = try container.decodeIfPresent(String.self, forKey: .payout)
  }

}
