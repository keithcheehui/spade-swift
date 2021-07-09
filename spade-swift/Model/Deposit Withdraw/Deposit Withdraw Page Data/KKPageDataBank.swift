//
//  KKPageDataBank.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKPageDataBank: Codable {

  enum CodingKeys: String, CodingKey {
    case name
    case id
    case maxDeposit = "max_deposit"
    case img
    case minWithdrawal = "min_withdrawal"
    case minDeposit = "min_deposit"
    case maxWithdrawal = "max_withdrawal"
    case code
  }

  var name: String?
  var id: Int?
  var maxDeposit: Int?
  var img: String?
  var minWithdrawal: Int?
  var minDeposit: Int?
  var maxWithdrawal: Int?
  var code: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    maxDeposit = try container.decodeIfPresent(Int.self, forKey: .maxDeposit)
    img = try container.decodeIfPresent(String.self, forKey: .img)
    minWithdrawal = try container.decodeIfPresent(Int.self, forKey: .minWithdrawal)
    minDeposit = try container.decodeIfPresent(Int.self, forKey: .minDeposit)
    maxWithdrawal = try container.decodeIfPresent(Int.self, forKey: .maxWithdrawal)
    code = try container.decodeIfPresent(String.self, forKey: .code)
  }

}
