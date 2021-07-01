//
//  KKApiClient.swift
//  spade-swift
//
//  Created by Keith CheeHui on 23/04/2021.
//

import UIKit
import Alamofire

class KKApiClient: NSObject {
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:ApiRouter, decoder: JSONDecoder = JSONDecoder()) -> Future<T> {
        return Future(operation: { completion in

            if (!KKUtil.isConnectedToInternet()) {
                completion(.failure("connection offline"))
                return
            }

            AF.request(route).validate()
                .responseDecodable(decoder: decoder, completionHandler: { (response: (AFDataResponse<T>)) in

                switch response.result {
                case .success(let value):
                    print("success = \(value)")
                    completion(.success(value))
                case .failure(let error):

                    guard let data = response.data else { return completion(.failure(error.localizedDescription)) }
                    
                    do {
                        let apiErrorDetail = try decoder.decode(KKApiErrorDetails.self, from: data)
                        print("failure data = \(apiErrorDetail)")

                        guard let apiMessage = apiErrorDetail.message
                        else {
                            return completion(.failure(error.localizedDescription))
                        }
                        return completion(.failure(apiMessage))
                    } catch {
                        completion(.failure("Unexpected error. Please try again."))
                    }
                }
            })
        })
    }
    
    //MARK: - Auth
    static func registerOTPRequest(phoneNumber: String) -> Future<KKOTPRequestResponse> {
        let parameter = [
            APIKeys.phoneNumber: phoneNumber
        ] as [String : Any]
     
        return performRequest(route: .registerOTPRequest(parameter: parameter))
    }
    
    static func registerOTPVerify(phoneNumber: String, otpCode: String) -> Future<KKGeneralResponse> {
        let parameter = [
            APIKeys.phoneNumber: phoneNumber,
            APIKeys.OTPCode: otpCode
        ] as [String : Any]
     
        return performRequest(route: .registerOTPVerify(parameter: parameter))
    }
    
    static func registration(username: String, password: String, phoneNumber: String) -> Future<KKUserCredential> {
        let parameter = [
            APIKeys.username: username,
            APIKeys.password: password,
            APIKeys.confirmPassword: password,
            APIKeys.phoneNumber: phoneNumber,
            APIKeys.registrationPlatform: Platform.iOS,
            APIKeys.type: RegistrationType.phoneNumber,
            APIKeys.countryCode: KKUtil.decodeUserCountryFromCache().code!
        ] as [String : Any]
        
        return performRequest(route: .registration(parameter: parameter))
    }
    
    static func login(username: String, password: String) -> Future<KKUserCredential> {
        let parameter = [
            APIKeys.username: username,
            APIKeys.password: password,
            APIKeys.type: LoginType.username
        ] as [String : Any]
        
        return performRequest(route: .login(parameter: parameter))
    }

    static func forgotPasswordOTPRequest(phoneNumber: String) -> Future<KKOTPRequestResponse> {
        let parameter = [
            APIKeys.phoneNumber: phoneNumber
        ] as [String : Any]
     
        return performRequest(route: .forgotPasswordOTPRequest(parameter: parameter))
    }
    
    static func forgotPasswordOTPVerify(phoneNumber: String, otpCode: String) -> Future<KKGeneralResponse> {
        let parameter = [
            APIKeys.phoneNumber: phoneNumber,
            APIKeys.OTPCode: otpCode
        ] as [String : Any]
     
        return performRequest(route: .forgotPasswordOTPVerify(parameter: parameter))
    }
    
    static func forgotPassword(password: String, phoneNumber: String) -> Future<KKGeneralResponse> {
        let parameter = [
            APIKeys.newPassword: password,
            APIKeys.confirmNewPassword: password,
            APIKeys.phoneNumber: phoneNumber,
            APIKeys.registrationPlatform: Platform.iOS,
            APIKeys.type: RegistrationType.phoneNumber,
            APIKeys.countryCode: KKUtil.decodeUserCountryFromCache().code!
        ] as [String : Any]
        
        return performRequest(route: .forgotPassword(parameter: parameter))
    }

    //MARK: - Public
    static func appVersion() -> Future<KKAppVersionResponse> {
        let parameter = [
            APIKeys.platform: Platform.iOS,
            APIKeys.locale: KKUtil.decodeUserLanguageFromCache().locale!
        ] as [String : Any]
        
        return performRequest(route: .appVersion(parameter: parameter))
    }
    
    static func guestLandingData() -> Future<KKLandingDetailsResponse> {
        let parameter = [
            APIKeys.locale: KKUtil.decodeUserLanguageFromCache().locale!,
            APIKeys.countryCode: KKUtil.decodeUserCountryFromCache().code!
        ] as [String : Any]
        
        return performRequest(route: .guestLandingData(parameter: parameter))
    }
    
    static func getGroupAndPlatform() -> Future<KKGroupPlatformResponse> {
        let parameter = [
            APIKeys.locale: KKUtil.decodeUserLanguageFromCache().locale!,
            APIKeys.countryCode: KKUtil.decodeUserCountryFromCache().code!
        ] as [String : Any]
        
        return performRequest(route: .getGroupAndPlatform(parameter: parameter))
    }
    
    static func getGameTypeListing(gCode: String = "") -> Future<KKPlatformProductResponse> {
        let parameter = [
            APIKeys.locale: KKUtil.decodeUserLanguageFromCache().locale!,
            APIKeys.groupCode: gCode
        ] as [String : Any]
        
        return performRequest(route: .getGameTypeListing(parameter: parameter))
    }
    
    static func getContentAnnouncement() ->  Future<KKAnnouncementResponse> {
        let parameter = [
            APIKeys.locale: KKUtil.decodeUserLanguageFromCache().locale!,
        ] as [String : Any]
        
        return performRequest(route: .getAnnouncement(parameter: parameter))
    }
    
    static func getFAQ() -> Future<KKFAQResponse> {
        let parameter = [
            APIKeys.locale: KKUtil.decodeUserLanguageFromCache().locale!,
        ] as [String : Any]
        
        return performRequest(route: .getFAQ(parameter: parameter))
    }
        
    static func getLiveChat() -> Future<KKLiveChatResponse> {
        let parameter = [
            APIKeys.locale: KKUtil.decodeUserLanguageFromCache().locale!
        ] as [String : Any]
        
        return performRequest(route: .getLiveChat(parameter: parameter))
    }
    
    static func getPromotion() -> Future<KKPromotionResponse> {
        let parameter = [
            APIKeys.locale: KKUtil.decodeUserLanguageFromCache().locale!,
        ] as [String : Any]
        
        return performRequest(route: .getPromotion(parameter: parameter))
    }
    
    static func getAffiliateGuideline() -> Future<KKGuidelineResponse> {
        let parameter = [
            APIKeys.locale: KKUtil.decodeUserLanguageFromCache().locale!
        ] as [String : Any]
        
        return performRequest(route: .getAffiliateGuideline(parameter: parameter))
    }
    
    //MARK: - Private
    //MARK: - Deposit / Withdrawal
    static func addUserBankCard(bankAccountNo: String, bankAccountName: String, bankId: String) -> Future<KKWithdrawBankResponse> {
        let parameter = [
            APIKeys.bankAccountNo: bankAccountNo,
            APIKeys.bankAccountName: bankAccountName,
            APIKeys.bankID: bankId
        ] as [String : Any]
        
        return performRequest(route: .addUserBankCard(parameter: parameter))
    }
    
    //TODO: Havent implement
    static func deleteUserBankCard(bankId: Int) -> Future<KKWithdrawBankResponse> {
        let parameter = [
            APIKeys.bankAccountCardId: bankId
        ] as [String : Any]
        
        return performRequest(route: .deleteUserBankCard(parameter: parameter))
    }
    
    //TODO: Havent implement
    static func depositPageData() -> Future<KKDepositBankResponse> {
        return performRequest(route: .depositPageData)
    }
    
    //TODO: Havent implement
    static func deposit(parameter: [String : Any]) -> Future<KKGeneralResponse> {
        return performRequest(route: .deposit(parameter: parameter))
    }
    
    static func depositHistory(historyStatus: String) -> Future<KKDepositHistoryResponse> {
        let parameter = [
            APIKeys.status: historyStatus
        ] as [String : Any]

        return performRequest(route: .depositHistory(parameter: parameter))
    }
        
    static func getWithdrawPageData() -> Future<KKWithdrawBankResponse> {
        return performRequest(route: .withdrawPageData)
    }
    
    static func withdraw(amount: Float, bankAcc: String) -> Future<KKGeneralResponse> {
        let parameter = [
            APIKeys.withdrawAmount: amount,
            APIKeys.withdrawAccountNo: bankAcc
        ] as [String : Any]
        
        return performRequest(route: .withdraw(parameter: parameter))
    }
    
    static func withdrawHistory(historyStatus: String) -> Future<KKWithdrawHistoryResponse> {
        let parameter = [
            APIKeys.status: historyStatus
        ] as [String : Any]
        
        return performRequest(route: .withdrawHistory(parameter: parameter))
    }

    //MARK: - Personal Center
    static func getUserProfile() -> Future<KKUserProfileResponse> {
        return performRequest(route: .getUserProfile)
    }
    
    static func updateUserProfile(email: String = KKUtil.decodeUserProfileFromCache()?.email ?? "",
                                  gender: String = KKUtil.decodeUserProfileFromCache()?.gender ?? GenderType.male.rawValue,
                                  birthday: String = KKUtil.decodeUserProfileFromCache()?.dob ?? "") -> Future<KKGeneralResponse> {
        let parameter = [
            APIKeys.email: email,
            APIKeys.gender: gender,
            APIKeys.birthday: birthday
        ] as [String : Any]
        
        return performRequest(route: .updateUserProfile(parameter: parameter))
    }
    
    static func getUserBettingPlatformsAndGroups() -> Future<KKUserBettingResponse> {
        let parameter = [
            APIKeys.locale: KKUtil.decodeUserLanguageFromCache().locale!,
        ] as [String : Any]
        
        return performRequest(route: .getUserBettingPlatformsAndGroups(parameter: parameter))
    }
    
    static func getUserAccountDetails(filter: String, tabItem: String) -> Future<KKUserCashFlowResponse> {
        let parameter = [
            APIKeys.filterDuration: filter,
            APIKeys.transStatus: tabItem
        ] as [String : Any]
        
        return performRequest(route: .getUserAccountDetails(parameter: parameter))
    }
    
    static func getUserBettingRecord(filter: String, code: String) -> Future<KKUserBettingHistoryResponse> {
        let parameter = [
            APIKeys.filterDuration : filter,
            APIKeys.code : code
        ] as [String : Any]
        
        return performRequest(route: .getUserBettingRecord(parameter: parameter))
    }
    
    //MARK: - Inbox
    static func getInbox() -> Future<KKInboxMessageResponse> {
        let parameter = [
            APIKeys.locale: KKUtil.decodeUserLanguageFromCache().locale!
        ] as [String : Any]
        
        return performRequest(route: .getInbox(parameter: parameter))
    }
    
    static func getInboxReadStatus() -> Future<KKInboxMessageResponse> {
        return performRequest(route: .getInboxReadStatus)
    }
    
    static func updateInboxReadStatus(msgId: Int) -> Future<KKGeneralResponse> {
        let parameter = [
            APIKeys.inboxMessageId    : msgId
        ] as [String : Any]
        
        return performRequest(route: .updateInboxReadStatus(parameter: parameter))
    }
    
    //MARK: - Private
    static func memberLandingData() -> Future<KKLandingDetailsResponse> {
        let parameter = [
            APIKeys.locale: KKUtil.decodeUserLanguageFromCache().locale!,
            APIKeys.countryCode: KKUtil.decodeUserCountryFromCache().code!
        ] as [String : Any]
        
        return performRequest(route: .memberLandingData(parameter: parameter))
    }
    
    static func getUserLatestWallet() -> Future<KKUserWalletResponse> {
        return performRequest(route: .getLatestWallet)
    }
    
    static func updateUserLanguagePreference(languageCode: String) -> Future<KKGeneralResponse> {
        let parameter = [
            APIKeys.locale: languageCode
        ] as [String : Any]
        
        return performRequest(route: .updateUserLanguagePreference(parameter: parameter))
    }
    
    static func changePassword(currentPwd: String, newPwd: String) -> Future<KKGeneralResponse> {
        let parameter = [
            APIKeys.currentPassword : currentPwd,
            APIKeys.newPassword : newPwd,
            APIKeys.confirmNewPassword : newPwd
        ] as [String : Any]
        
        return performRequest(route: .changePassword(parameter: parameter))
    }
    
    static func logOutUser() -> Future<KKGeneralResponse> {
        return performRequest(route: .logOutUser)
    }
}

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
