//
//  KKPromotions.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKDepositDataPromotions: Codable {

  enum CodingKeys: String, CodingKey {
    case amount
    case startDate = "start_date"
    case endDate = "end_date"
    case promoCode = "promo_code"
    case name
    case type
  }

  var amount: String?
  var startDate: String?
  var endDate: String?
  var promoCode: String?
  var name: String?
  var type: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    amount = try container.decodeIfPresent(String.self, forKey: .amount)
    startDate = try container.decodeIfPresent(String.self, forKey: .startDate)
    endDate = try container.decodeIfPresent(String.self, forKey: .endDate)
    promoCode = try container.decodeIfPresent(String.self, forKey: .promoCode)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    type = try container.decodeIfPresent(String.self, forKey: .type)
  }

}
