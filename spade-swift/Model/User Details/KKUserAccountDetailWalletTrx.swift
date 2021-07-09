//
//  KKUserAccountDetailWalletTrx.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserAccountDetailWalletTrx: Codable {

  enum CodingKeys: String, CodingKey {
    case balance
    case tIn = "in"
    case descriptionValue = "description"
    case trxDate = "trx_date"
    case tOut = "out"
  }

  var balance: String?
  var tIn: String?
  var descriptionValue: String?
  var trxDate: String?
  var tOut: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    balance = try container.decodeIfPresent(String.self, forKey: .balance)
    tIn = try container.decodeIfPresent(String.self, forKey: .tIn)
    descriptionValue = try container.decodeIfPresent(String.self, forKey: .descriptionValue)
    trxDate = try container.decodeIfPresent(String.self, forKey: .trxDate)
    tOut = try container.decodeIfPresent(String.self, forKey: .tOut)
  }

}
