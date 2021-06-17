//
//  KKApiRouter.swift
//  spade-swift
//
//  Created by Keith CheeHui on 23/04/2021.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    // MARK: - APP Version
    case appVersion(parameter: [String: Any])
    
    // MARK: - Guest/Member Landing
    case guestLandingDetails(parameter: [String: Any])
    case memberLandingDetails(parameter: [String: Any])
    
    // MARK: - OTP
    case otpRequest(parameter: [String: Any])
    case otpVerify(parameter: [String: Any])
    
    // MARK: - OAuth
    case userAccountLogin(parameter: [String: Any])
    case userAccountRegistration(parameter: [String: Any])
    case userForgotPassword(parameter: [String: Any])
    case logOutUser
    
    // MARK: - User Profile
    case getUserProfile
    case updateUserProfile(parameter: [String: Any])
    case updateUserLanguagePreference(parameter: [String: Any])
    
    // MARK: - User Details
    case getLatestWallet
    case getUserBettingGroupAndPlatform(parameter: [String: Any])
    case getUserBettingRecord(parameter: [String: Any])
    case getUserBettingCashflow(parameter: [String: Any])
    
    // MARK: - Content
    case getAnnouncementContent(parameter: [String: Any])
    case getGroupAndPlatformContent(parameter: [String: Any])
    case getPlatformProductsContent(parameter: [String: Any])
    case getSystemMessageContent(parameter: [String: Any])
    case getPromotionContent(parameter: [String: Any])
    case getAffiliateGuidelineContent(parameter: [String: Any])
    
    // MARK: - Customer Service
    case customerFAQ(parameter: [String: Any])
    case customerLiveChat(parameter: [String: Any])
    
    // MARK:- Member Deposit
    case memberDepositBankAccount
    case memberDeposit(parameter: [String: Any])
    case memberDepositHistory(parameter: [String: Any])
    
    // MARK:- Member Withdraw
    case addMemberWithdrawBankAccount(parameter: [String: Any])
    case memberWithdrawBankAccount
    case memberWithdrawal(parameter: [String: Any])
    case memberWithdrawHistory(parameter: [String: Any])
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        
        switch self {
        
        case .appVersion,
             .guestLandingDetails,
             .memberLandingDetails,
             .getUserProfile,
             .getLatestWallet,
             .getUserBettingGroupAndPlatform,
             .getUserBettingRecord,
             .getUserBettingCashflow,
             .customerFAQ,
             .customerLiveChat,
             .getAnnouncementContent,
             .getGroupAndPlatformContent,
             .getPlatformProductsContent,
             .getSystemMessageContent,
             .getPromotionContent,
             .getAffiliateGuidelineContent,
             .memberDepositBankAccount,
             .memberDepositHistory,
             .memberWithdrawBankAccount,
             .memberWithdrawHistory:
            return .get
        
        case .otpRequest,
             .otpVerify,
             .userAccountLogin,
             .userAccountRegistration,
             .userForgotPassword,
             .addMemberWithdrawBankAccount,
             .logOutUser:
            return .post
            
        case .updateUserProfile,
             .updateUserLanguagePreference,
             .memberDeposit,
             .memberWithdrawal:
            return .put
        }
    }
    
    // MARK: - Path
    private var path: String {
        
        switch self {
        
        case .appVersion:
            return "version"
            
        case .guestLandingDetails:
            return "content/guestLanding"
            
        case .memberLandingDetails:
            return "member/memberLanding"
        
        case .otpRequest:
            return "otp/request"
        
        case .otpVerify:
            return "otp/verify"
            
        case .userAccountLogin:
            return "login"
            
        case .userAccountRegistration:
            return "register"
            
        case .userForgotPassword:
            return "password/forgot"
            
        case .getUserProfile:
            return "member/profile"
            
        case .updateUserProfile:
            return "member/updateUserProfile"
            
        case .updateUserLanguagePreference:
            return "member/updateUserLanguagePreference"
            
        case .getLatestWallet:
            return "member/latestWalletBalance"
            
        case .getUserBettingGroupAndPlatform:
            return "member/betslipsPlatformsAndGroups"
                
        case .getUserBettingRecord:
            return "member/betslips"
                
        case .getUserBettingCashflow:
            return "member/cashflows"
            
        case .customerFAQ:
            return "customer_service/faqs"
            
        case .customerLiveChat:
            return "customer_service/live_chats"
            
        case .getAnnouncementContent:
            return "content/announcements"
            
        case .getGroupAndPlatformContent:
            return "content/groups"
            
        case .getPlatformProductsContent:
            return "content/products"
            
        case .getSystemMessageContent:
            return "content/system_messages"
            
        case .getPromotionContent:
            return "content/promotions"
            
        case .getAffiliateGuidelineContent:
            return "content/affiliate_guidelines"
            
        case .memberDepositBankAccount:
            return "member/deposit/bankAccounts"
            
        case .memberDeposit:
            return "member/deposit/deposit"
        
        case .memberDepositHistory:
            return "depositHistory"
            
        case .addMemberWithdrawBankAccount:
            return "member/withdraw/addUserBankAccount"
            
        case .memberWithdrawBankAccount:
            return "member/withdraw/bankAccounts"
            
        case .memberWithdrawal:
            return "member/withdraw/withdrawal"
                
        case .memberWithdrawHistory:
            return "member/withdraw/withdrawHistory"
            
        case .logOutUser:
            return "logout"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
           
        switch self {
        
        case .appVersion(let parameter):
            return parameter
            
        case .guestLandingDetails(let parameter):
            return parameter
            
        case .memberLandingDetails(let parameter):
            return parameter
            
        case .otpRequest(let parameter):
            return parameter
            
        case .otpVerify(let parameter):
            return parameter
            
        case .userAccountLogin(let parameter):
            return parameter
            
        case .userAccountRegistration(let parameter):
            return parameter
            
        case .userForgotPassword(let parameter):
            return parameter
            
        case .updateUserProfile(let parameter):
            return parameter
            
        case .updateUserLanguagePreference(let parameter):
            return parameter
            
        case .getUserBettingGroupAndPlatform(let parameter):
            return parameter
            
        case .getUserBettingRecord(let parameter):
            return parameter
            
        case .getUserBettingCashflow(let parameter):
            return parameter
            
        case .customerFAQ(let parameter):
            return parameter
            
        case .customerLiveChat(let parameter):
            return parameter
            
        case .getAnnouncementContent(let parameter):
            return parameter
            
        case .getGroupAndPlatformContent(let parameter):
            return parameter
            
        case .getPlatformProductsContent(let parameter):
            return parameter
            
        case .getSystemMessageContent(let parameter):
            return parameter
            
        case .getPromotionContent(let parameter):
            return parameter

        case .getAffiliateGuidelineContent(let parameter):
            return parameter
            
        case .memberDeposit(let parameter):
            return parameter
            
        case .memberDepositHistory(let parameter):
            return parameter
            
        case .addMemberWithdrawBankAccount(let parameter):
            return parameter
            
        case .memberWithdrawal(let parameter):
            return parameter
            
        case .memberWithdrawHistory(let parameter):
            return parameter
            
        case .getUserProfile,
             .getLatestWallet,
             .memberDepositBankAccount,
             .memberWithdrawBankAccount,
             .logOutUser:
            return nil
        }
    }
    
    // MARK: - URL Request
    func asURLRequest() throws -> URLRequest {
        
        let url : URL = try Spade.DevServer.baseApiURL.asURL()
        
        var urlRequest : URLRequest = URLRequest(url: url.appendingPathComponent(path))
        
        if (method.rawValue == "GET" && parameters != nil)
        {
            let dict: NSDictionary = parameters! as NSDictionary

            for i in 0 ..< dict.allKeys.count {

                urlRequest = URLRequest(url: KKUtil.addQueryParams(url: urlRequest.url!, newParams: [URLQueryItem.init(name: dict.allKeys[i] as! String, value: (dict.object(forKey: dict.allKeys[i]) as! String))])!)
            }
        }
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if (UserDefaults.standard.bool(forKey: CacheKey.loginStatus))
        {
            urlRequest.setValue(String(format: "Bearer %@", KKTokenManager.accessToken()), forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        }

        // Parameters
        if let parameters = parameters
        {
            do
            {
                if (urlRequest.httpMethod == "POST" || urlRequest.httpMethod == "DELETE" || urlRequest.httpMethod == "PUT")
                {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                }
            }
            catch
            {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }

    
}
