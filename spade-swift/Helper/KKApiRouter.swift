//
//  KKApiRouter.swift
//  spade-swift
//
//  Created by Keith CheeHui on 23/04/2021.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    //MARK: - Auth
    case registerOTPRequest(parameter: [String: Any])
    case registerOTPVerify(parameter: [String: Any])
    case registration(parameter: [String: Any])
    case login(parameter: [String: Any])
    case forgotPasswordOTPRequest(parameter: [String: Any])
    case forgotPasswordOTPVerify(parameter: [String: Any])
    case forgotPassword(parameter: [String: Any])

    //MARK: - Public
    case appVersion(parameter: [String: Any])
    case guestLandingData(parameter: [String: Any])
    case getGroupAndPlatform(parameter: [String: Any])
    case getGameTypeListing(parameter: [String: Any])
    case getAnnouncement(parameter: [String: Any])
    case getFAQ(parameter: [String: Any])
    case getLiveChat(parameter: [String: Any])
    case getPromotion(parameter: [String: Any])
    
    //MARK: - Private
    //MARK: - Deposit / Withdrawal
    case addUserBankCard(parameter: [String: Any])
    case getBankList
    case userBankCards
    case depositPageData
//    case deposit(parameter: [String: Any])
    case deposit
    case depositHistory(parameter: [String: Any])
    case withdrawPageData
    case withdraw(parameter: [String: Any])
    case withdrawHistory(parameter: [String: Any])

    //MARK: - Personal Center
    case getUserProfile
    case updateUserProfile(parameter: [String: Any])
    case updateUserAvatar(parameter: [String: Any])
    case getUserBettingPlatformsAndGroups(parameter: [String: Any])
    case getUserAccountDetails(parameter: [String: Any])
    case getHistory(parameter: [String: Any])
    case getUserBettingRecord(parameter: [String: Any])
    
    //MARK: - Inbox
    case getInbox(parameter: [String: Any])
    case getInboxReadStatus
    case updateInboxReadStatus(parameter: [String: Any])
    
    //MARK: - Rebate
    case rebateProfile
    case rebatePayout(parameter: [String: Any])
    case rebateTransaction(parameter: [String: Any])
    case rebateTable
    case rebateCollect(parameter: [String: Any])

    //MARK: - Affiliate
    case myAffiliate
    case getAffiliateGuideline(parameter: [String: Any])
    case affiliateDownline
    case affiliateTurnover(parameter: [String: Any])
    case affiliatePayout(parameter: [String: Any])
    case affiliateCommissionTransaction(parameter: [String: Any])
    case commissionTable
    case affiliateCollect(parameter: [String: Any])
    
    case memberLandingData(parameter: [String: Any])
    case getLatestWallet
    case updateUserLanguagePreference(parameter: [String: Any])
    case changePassword(parameter: [String: Any])
    case logOutUser
    
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        
        switch self {
        
        case .appVersion,
             .guestLandingData,
             .getGroupAndPlatform,
             .getGameTypeListing,
             .getAnnouncement,
             .getFAQ,
             .getLiveChat,
             .getPromotion,
             .getBankList,
             .userBankCards,
             .depositPageData,
             .depositHistory,
             .withdrawPageData,
             .withdrawHistory,
             .getUserProfile,
             .getUserBettingPlatformsAndGroups,
             .getUserAccountDetails,
             .getHistory,
             .getUserBettingRecord,
             .getInbox,
             .getInboxReadStatus,
             .rebateProfile,
             .rebatePayout,
             .rebateTransaction,
             .rebateTable,
             .myAffiliate,
             .getAffiliateGuideline,
             .affiliateDownline,
             .affiliateTurnover,
             .affiliatePayout,
             .affiliateCommissionTransaction,
             .commissionTable,
             .memberLandingData,
             .getLatestWallet:
            return .get
        
        case .registerOTPRequest,
             .registerOTPVerify,
             .registration,
             .login,
             .forgotPasswordOTPRequest,
             .forgotPasswordOTPVerify,
             .forgotPassword,
             .addUserBankCard,
             .deposit,
             .withdraw,
             .updateInboxReadStatus,
             .rebateCollect,
             .affiliateCollect,
             .changePassword,
             .logOutUser:
            return .post
            
        case .updateUserProfile,
             .updateUserAvatar,
             .updateUserLanguagePreference:
            return .put
        }
    }
    
    // MARK: - Path
    private var path: String {
        
        switch self {
        
        case .registerOTPRequest:
            return "otp/request"
            
        case .registerOTPVerify:
            return "otp/verify"
            
        case .registration:
            return "register"
            
        case .login:
            return "login"

        case .forgotPasswordOTPRequest:
            return "otp/forgot/request"
            
        case .forgotPasswordOTPVerify:
            return "otp/forgot/verify"
            
        case .forgotPassword:
            return "password/forgot"
            
        case .appVersion:
            return "version"
        
        case .guestLandingData:
            return "content/guestLanding"
            
        case .getGroupAndPlatform:
            return "content/groups"
            
        case .getGameTypeListing:
            return "content/gameTypeListing"
            
        case .getAnnouncement:
            return "content/announcements"
            
        case .getFAQ:
            return "customerService/faqs"
            
        case .getLiveChat:
            return "customerService/liveChats"
            
        case .getPromotion:
            return "content/promotions"
            
        case .addUserBankCard:
            return "member/finance/addUserBankCard"
            
        case .getBankList:
            return "member/finance/bankList"
            
        case .userBankCards:
            return "member/finance/userBankCards"
                        
        case .depositPageData:
            return "member/deposit/depositPageData"
            
        case .deposit:
            return "member/deposit/deposit"
        
        case .depositHistory:
            return "member/deposit/depositHistory"
            
        case .withdrawPageData:
            return "member/withdraw/withdrawPageData"
            
        case .withdraw:
            return "member/withdraw/withdrawal"
                
        case .withdrawHistory:
            return "member/withdraw/withdrawHistory"
            
        case .getUserProfile:
            return "member/profile"
            
        case .updateUserProfile:
            return "member/updateUserProfile"
            
        case .updateUserAvatar:
            return "member/updateUserAvatar"
            
        case .getUserBettingPlatformsAndGroups:
            return "member/betslipsPlatformsAndGroups"
            
        case .getUserAccountDetails:
            return "member/account/detail"
            
        case .getHistory:
            return "member/history"
            
        case .getUserBettingRecord:
            return "member/betslips"
            
        case .getInbox:
            return "member/inbox"
            
        case .getInboxReadStatus:
            return "member/inboxUnreadMsgsBoolean"
            
        case .updateInboxReadStatus:
            return "member/updateInboxReadStatus"
            
        case .rebateProfile:
            return "member/rebate/profile"
            
        case .rebatePayout:
            return "member/rebate/payout"
            
        case .rebateTransaction:
            return "member/rebate/transaction"
            
        case .rebateTable:
            return "member/rebate/rebateTable"
            
        case .rebateCollect:
            return "member/rebate/collect"
            
        case .myAffiliate:
            return "member/affiliate/myAffiliate"
            
        case .getAffiliateGuideline:
            return "content/affiliate_guidelines"
            
        case .affiliateDownline:
            return "member/affiliate/affiliateDownline"
            
        case .affiliateTurnover:
            return "member/affiliate/affiliateTurnover"
            
        case .affiliatePayout:
            return "member/affiliate/affiliatePayout"
            
        case .affiliateCommissionTransaction:
            return "member/affiliate/affiliateCommissionTransaction"
            
        case .commissionTable:
            return "member/affiliate/commissionTable"
            
        case .affiliateCollect:
            return "member/affiliate/collect"
            
        case .memberLandingData:
            return "member/memberLanding"
            
        case .getLatestWallet:
            return "member/latestWalletBalance"
        
        case .updateUserLanguagePreference:
            return "member/updateUserLanguagePreference"
            
        case .changePassword:
            return "member/password/change"
            
        case .logOutUser:
            return "logout"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
           
        switch self {
        case .registerOTPRequest(let parameter),
             .registerOTPVerify(let parameter),
             .registration(let parameter),
             .login(let parameter),
             .forgotPasswordOTPRequest(let parameter),
             .forgotPasswordOTPVerify(let parameter),
             .forgotPassword(let parameter),
             .appVersion(let parameter),
             .guestLandingData(let parameter),
             .getGroupAndPlatform(let parameter),
             .getGameTypeListing(let parameter),
             .getAnnouncement(let parameter),
             .getFAQ(let parameter),
             .getLiveChat(let parameter),
             .getPromotion(let parameter),
             .getAffiliateGuideline(let parameter),
             .addUserBankCard(let parameter),
             .depositHistory(let parameter),
             .withdraw(let parameter),
             .withdrawHistory(let parameter),
             .updateUserProfile(let parameter),
             .updateUserAvatar(let parameter),
             .getUserBettingPlatformsAndGroups(let parameter),
             .getUserAccountDetails(let parameter),
             .getHistory(let parameter),
             .getUserBettingRecord(let parameter),
             .getInbox(let parameter),
             .updateInboxReadStatus(let parameter),
             .rebateCollect(let parameter),
             .rebatePayout(let parameter),
             .rebateTransaction(let parameter),
             .affiliateTurnover(let parameter),
             .affiliatePayout(let parameter),
             .affiliateCommissionTransaction(let parameter),
             .affiliateCollect(let parameter),
             .memberLandingData(let parameter),
             .updateUserLanguagePreference(let parameter),
             .changePassword(let parameter):
            return parameter
            
        case .getInboxReadStatus,
             .getBankList,
             .userBankCards,
             .depositPageData,
             .withdrawPageData,
             .getUserProfile,
             .rebateProfile,
             .rebateTable,
             .myAffiliate,
             .affiliateDownline,
             .commissionTable,
             .getLatestWallet,
             .logOutUser,
             .deposit:
            return nil
        }
    }
    
    // MARK: - URL Request
    func asURLRequest() throws -> URLRequest {
        
        let url : URL = try Spade.StagingServer.baseApiURL.asURL()
        
        var urlRequest : URLRequest = URLRequest(url: url.appendingPathComponent(path))
        
        if method.rawValue == "GET" && parameters != nil {
            
            if let dict = parameters as? [String: String] {
            
                if let url = KKUtil.addQueryParams(url: urlRequest.url!, parameters: dict) {
                    
                    urlRequest = URLRequest(url: url)
                    
                } else {
                    
                    urlRequest = URLRequest(url: url.appendingPathComponent(path))
                }
            }
        }
        
        urlRequest.httpMethod = method.rawValue
//        urlRequest.setValue(HTTPHeaderFieldValue.contentType.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(HTTPHeaderFieldValue.contentType.rawValue, forHTTPHeaderField: HTTPHeaderField.accept.rawValue)

        switch self {
        case .deposit:
            urlRequest.setValue(HTTPHeaderFieldValue.multipartContentType.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        default:
            urlRequest.setValue(HTTPHeaderFieldValue.contentType.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        }
        
        if KKUtil.isUserLogin() {
            urlRequest.setValue(String(format: "Bearer %@", KKTokenManager.accessToken()), forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        }

        // Parameters
        if let parameters = parameters {
            do {
                if (urlRequest.httpMethod == "POST" || urlRequest.httpMethod == "DELETE" || urlRequest.httpMethod == "PUT") {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                }
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }

    
}
