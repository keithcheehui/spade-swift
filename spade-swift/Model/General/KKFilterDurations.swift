//
//  KKPageDataFilterDurations.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKFilterDurations: Codable {

  enum CodingKeys: String, CodingKey {
    case td = "TODAY"
    case yd = "YESTERDAY"
    case l7d = "LAST_7_DAYS"
    case l30d = "LAST_30_DAYS"
  }

    var td: String?
    var yd: String?
    var l7d: String?
    var l30d: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    td = try container.decodeIfPresent(String.self, forKey: .td)
    yd = try container.decodeIfPresent(String.self, forKey: .yd)
    l7d = try container.decodeIfPresent(String.self, forKey: .l7d)
    l30d = try container.decodeIfPresent(String.self, forKey: .l30d)
  }

}
