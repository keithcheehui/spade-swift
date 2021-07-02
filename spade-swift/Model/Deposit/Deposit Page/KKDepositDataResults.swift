//
//  KKResults.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKDepositDataResults: Codable {

  enum CodingKeys: String, CodingKey {
    case depositRange = "deposit_range"
    case depositChannels = "deposit_channels"
    case companyBanks = "company_banks"
    case userBankCards = "user_bank_cards"
    case promotions
  }

  var depositRange: KKRange?
  var depositChannels: [KKDepositChannels]?
  var companyBanks: [KKCompanyBanks]?
  var userBankCards: [KKUserBankCards]?
  var promotions: [KKDepositDataPromotions]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    depositRange = try container.decodeIfPresent(KKRange.self, forKey: .depositRange)
    depositChannels = try container.decodeIfPresent([KKDepositChannels].self, forKey: .depositChannels)
    companyBanks = try container.decodeIfPresent([KKCompanyBanks].self, forKey: .companyBanks)
    userBankCards = try container.decodeIfPresent([KKUserBankCards].self, forKey: .userBankCards)
    promotions = try container.decodeIfPresent([KKDepositDataPromotions].self, forKey: .promotions)
  }

}
