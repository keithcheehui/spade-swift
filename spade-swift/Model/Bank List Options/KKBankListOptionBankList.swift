//
//  KKBankListOptionBankList.swift
//
//  Created by Wong Sai Khong on 06/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKBankListOptionBankList: Codable {

  enum CodingKeys: String, CodingKey {
    case maxDeposit = "max_deposit"
    case maxWithdrawal = "max_withdrawal"
    case minWithdrawal = "min_withdrawal"
    case minDeposit = "min_deposit"
    case code
    case id
    case name
  }

  var maxDeposit: Int?
  var maxWithdrawal: Int?
  var minWithdrawal: Int?
  var minDeposit: Int?
  var code: String?
  var id: Int?
  var name: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    maxDeposit = try container.decodeIfPresent(Int.self, forKey: .maxDeposit)
    maxWithdrawal = try container.decodeIfPresent(Int.self, forKey: .maxWithdrawal)
    minWithdrawal = try container.decodeIfPresent(Int.self, forKey: .minWithdrawal)
    minDeposit = try container.decodeIfPresent(Int.self, forKey: .minDeposit)
    code = try container.decodeIfPresent(String.self, forKey: .code)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    name = try container.decodeIfPresent(String.self, forKey: .name)
  }

}
