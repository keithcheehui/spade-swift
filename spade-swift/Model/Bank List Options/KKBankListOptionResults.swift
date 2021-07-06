//
//  KKBankListOptionResults.swift
//
//  Created by Wong Sai Khong on 06/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKBankListOptionResults: Codable {

  enum CodingKeys: String, CodingKey {
    case bankList = "bank_list"
  }

  var bankList: [KKBankListOptionBankList]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    bankList = try container.decodeIfPresent([KKBankListOptionBankList].self, forKey: .bankList)
  }

}
