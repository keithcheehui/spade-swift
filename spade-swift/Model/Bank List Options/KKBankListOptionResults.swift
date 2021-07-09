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

  var bankList: [KKPageDataBank]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    bankList = try container.decodeIfPresent([KKPageDataBank].self, forKey: .bankList)
  }

}
