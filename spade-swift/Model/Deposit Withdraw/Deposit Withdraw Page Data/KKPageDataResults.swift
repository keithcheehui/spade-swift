//
//  KKPageDataResults.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKPageDataResults: Codable {

  enum CodingKeys: String, CodingKey {
    case filterDurations = "filter_durations"
    case userBankCards = "user_bank_cards"
    case companyBanks = "company_banks"
    case depositChannels = "deposit_channels"
    case user
    case promotions
  }

  var filterDurations: KKPageDataFilterDurations?
  var userBankCards: [KKPageDataUserBankCards]?
  var companyBanks: [KKPageDataUserBankCards]?
  var depositChannels: [KKPageDataDepositChannels]?
  var user: KKPageDataUser?
  var promotions: [KKPageDataPromotions]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    filterDurations = try container.decodeIfPresent(KKPageDataFilterDurations.self, forKey: .filterDurations)
    userBankCards = try container.decodeIfPresent([KKPageDataUserBankCards].self, forKey: .userBankCards)
    companyBanks = try container.decodeIfPresent([KKPageDataUserBankCards].self, forKey: .companyBanks)
    depositChannels = try container.decodeIfPresent([KKPageDataDepositChannels].self, forKey: .depositChannels)
    user = try container.decodeIfPresent(KKPageDataUser.self, forKey: .user)
    promotions = try container.decodeIfPresent([KKPageDataPromotions].self, forKey: .promotions)
  }

}
