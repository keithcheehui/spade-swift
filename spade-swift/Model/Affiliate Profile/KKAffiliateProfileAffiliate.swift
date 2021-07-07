//
//  KKAffiliateProfileAffiliate.swift
//
//  Created by Wong Sai Khong on 08/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateProfileAffiliate: Codable {

  enum CodingKeys: String, CodingKey {
    case memberRecruited = "member_recruited"
    case commission
    case referrerCode = "referrer_code"
    case affiliateUrl = "affiliate_url"
  }

  var memberRecruited: Int?
  var commission: KKAffiliateProfileCommission?
    var referrerCode: String?
    var affiliateUrl: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    memberRecruited = try container.decodeIfPresent(Int.self, forKey: .memberRecruited)
    commission = try container.decodeIfPresent(KKAffiliateProfileCommission.self, forKey: .commission)
    referrerCode = try container.decodeIfPresent(String.self, forKey: .referrerCode)
    affiliateUrl = try container.decodeIfPresent(String.self, forKey: .affiliateUrl)
  }

}
