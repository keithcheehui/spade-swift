//
//  KKPageDataFilterDurations.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKPageDataFilterDurations: Codable {

  enum CodingKeys: String, CodingKey {
    case lAST7DAYS = "LAST_7_DAYS"
    case lAST30DAYS = "LAST_30_DAYS"
  }

  var lAST7DAYS: String?
  var lAST30DAYS: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    lAST7DAYS = try container.decodeIfPresent(String.self, forKey: .lAST7DAYS)
    lAST30DAYS = try container.decodeIfPresent(String.self, forKey: .lAST30DAYS)
  }

}
