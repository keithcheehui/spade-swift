//
//  KKRebatePayoutGroup.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKPayoutGroup: Codable {

  enum CodingKeys: String, CodingKey {
    case code
    case payouts
    case name
    case id
    case totalRebate = "total_rebate"
    case totalCommission = "total_commission"
  }

  var code: String?
  var payouts: [KKPayoutPayouts]?
  var name: String?
  var id: Int?
    var totalRebate: String?
    var totalCommission: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    code = try container.decodeIfPresent(String.self, forKey: .code)
    payouts = try container.decodeIfPresent([KKPayoutPayouts].self, forKey: .payouts)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    totalRebate = try container.decodeIfPresent(String.self, forKey: .totalRebate)
    totalCommission = try container.decodeIfPresent(String.self, forKey: .totalCommission)
  }

}
