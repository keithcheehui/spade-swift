//
//  KKRebateTableResults.swift
//
//  Created by Wong Sai Khong on 06/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKRebateTableResults: Codable {

  enum CodingKeys: String, CodingKey {
    case rebateTable = "rebate_table"
  }

  var rebateTable: [KKRebateTableRebateTable]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    rebateTable = try container.decodeIfPresent([KKRebateTableRebateTable].self, forKey: .rebateTable)
  }

}
