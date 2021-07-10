//
//  KKUserAccountDetailResults.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserAccountDetailResults: Codable {

  enum CodingKeys: String, CodingKey {
    case filterDurations = "filter_durations"
    case walletTrx = "wallet_trx"
    case user
  }

  var filterDurations: KKFilterDurations?
  var walletTrx: [KKUserAccountDetailWalletTrx]?
  var user: KKHeaderUserDetails?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    filterDurations = try container.decodeIfPresent(KKFilterDurations.self, forKey: .filterDurations)
    walletTrx = try container.decodeIfPresent([KKUserAccountDetailWalletTrx].self, forKey: .walletTrx)
    user = try container.decodeIfPresent(KKHeaderUserDetails.self, forKey: .user)
  }

}
