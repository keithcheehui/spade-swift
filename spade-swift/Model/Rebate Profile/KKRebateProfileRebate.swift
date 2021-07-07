//
//  KKRebateProfileRebate.swift
//
//  Created by Wong Sai Khong on 08/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKRebateProfileRebate: Codable {

  enum CodingKeys: String, CodingKey {
    case totalRebate = "total_rebate"
    case availableRebate = "available_rebate"
  }

  var totalRebate: String?
  var availableRebate: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    totalRebate = try container.decodeIfPresent(String.self, forKey: .totalRebate)
    availableRebate = try container.decodeIfPresent(String.self, forKey: .availableRebate)
  }

}
