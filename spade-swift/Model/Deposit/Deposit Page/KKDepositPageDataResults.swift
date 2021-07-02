//
//  KKDepositPageDataResults.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKDepositPageDataResults: Codable {

  enum CodingKeys: String, CodingKey {
    case companyBanks = "company_banks"
    case userBankCards = "user_bank_cards"
    case depositChannels = "deposit_channels"
    case promotions
  }

  var companyBanks: [KKPageDataUserBankCards]?
  var userBankCards: [KKPageDataUserBankCards]?
  var depositChannels: [KKDepositPageDataDepositChannels]?
  var promotions: [KKDepositPageDataPromotions]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    companyBanks = try container.decodeIfPresent([KKPageDataUserBankCards].self, forKey: .companyBanks)
    userBankCards = try container.decodeIfPresent([KKPageDataUserBankCards].self, forKey: .userBankCards)
    depositChannels = try container.decodeIfPresent([KKDepositPageDataDepositChannels].self, forKey: .depositChannels)
    promotions = try container.decodeIfPresent([KKDepositPageDataPromotions].self, forKey: .promotions)
  }

}
