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
                        
                        if let apiCode = apiErrorDetail.code, let apiMessage = apiErrorDetail.message {
                            if (apiCode == 401 && apiMessage == "Unauthenticated.") {
                                KKUtil.forceLogoutUser()
                                return
                            }
                            return completion(.failure(apiMessage))
                        } else {
                            return completion(.failure(error.localizedDescription))
                        }
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
            APIKeys.faqCode: "GNL"
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
    
    //MARK: - Private
    //MARK: - Deposit / Withdrawal
    static func addUserBankCard(bankAccountNo: String, bankAccountName: String, bankId: String) -> Future<KKAddBankResponse> {
        let parameter = [
            APIKeys.bankAccountNo: bankAccountNo,
            APIKeys.bankAccountName: bankAccountName,
            APIKeys.bankID: bankId
        ] as [String : Any]
        
        return performRequest(route: .addUserBankCard(parameter: parameter))
    }
    
    static func getBankList() -> Future<KKBankListOptionResponse> {
        return performRequest(route: .getBankList)
    }
    
    static func getUserBankCards() -> Future<KKPageDataResponse> {
        return performRequest(route: .userBankCards)
    }
    
    static func depositPageData() -> Future<KKPageDataResponse> {
        return performRequest(route: .depositPageData)
    }
    
    static func deposit(imageData: Data, parameter: [String : Any]) -> Future<KKGeneralResponse> {
        return Future(operation: {completion in
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: APIKeys.receipt, fileName: "Receipt.jpeg", mimeType: "image/jpeg")
                for (key, value) in parameter {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            },
            with: ApiRouter.deposit)
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseJSON(completionHandler: {response in
                //Do what ever you want to do with response
        
                if response.data != nil {
                    let response: KKGeneralResponse = try! JSONDecoder().decode(KKGeneralResponse.self, from: response.data!)
                    if response.error != nil {
                        if let isError = response.error {
                            if isError {
                                completion(.failure(response.message ?? ""))
                            } else {
                                completion(.success(response))
                            }
                        } else {
                            completion(.failure(response.message ?? ""))
                        }
                    } else {
                        completion(.failure("Unexpected error. Please try again."))
                    }
                }
            })
        })
    }
    
    static func depositHistory(filter: String, historyStatus: String) -> Future<KKHistoryResponse> {
        let parameter = [
            APIKeys.filterDuration: filter,
            APIKeys.status: historyStatus
        ] as [String : Any]
        return performRequest(route: .depositHistory(parameter: parameter))
    }
        
    static func withdrawPageData() -> Future<KKPageDataResponse> {
        return performRequest(route: .withdrawPageData)
    }
    
    static func withdraw(amount: Float, bankId: Int) -> Future<KKGeneralResponse> {
        let parameter = [
            APIKeys.withdrawAmount: amount,
            APIKeys.userBankCardId: bankId
        ] as [String : Any]
        
        return performRequest(route: .withdraw(parameter: parameter))
    }
    
    static func withdrawHistory(filter: String, historyStatus: String) -> Future<KKHistoryResponse> {
        let parameter = [
            APIKeys.filterDuration: filter,
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
    
    static func updateUserAvatar(avatarId: Int) -> Future<KKGeneralResponse> {
        let parameter = [
            APIKeys.avatarId: avatarId
        ] as [String : Any]
        
        return performRequest(route: .updateUserAvatar(parameter: parameter))
    }
    
    static func getUserBettingPlatformsAndGroups() -> Future<KKUserBettingResponse> {
        let parameter = [
            APIKeys.locale: KKUtil.decodeUserLanguageFromCache().locale!,
        ] as [String : Any]
        
        return performRequest(route: .getUserBettingPlatformsAndGroups(parameter: parameter))
    }
    
    static func getUserAccountDetails(filter: String) -> Future<KKUserAccountDetailResponse> {
        let parameter = [
            APIKeys.filterDuration: filter
        ] as [String : Any]
        
        return performRequest(route: .getUserAccountDetails(parameter: parameter))
    }
    
    static func getHistory(filter: String, status: String, tabItem: String) -> Future<KKUserHistoryResponse> {
        let parameter = [
            APIKeys.filterDuration: filter,
            APIKeys.status: status
        ] as [String : Any]
        
        if tabItem == HistoryTab.deposit.rawValue {
            return performRequest(route: .getHistoryDeposit(parameter: parameter))
        } else if tabItem == HistoryTab.withdraw.rawValue {
            return performRequest(route: .getHistoryWithdraw(parameter: parameter))
        } else if tabItem == HistoryTab.transfer.rawValue {
            return performRequest(route: .getHistoryTransfer(parameter: parameter))
        } else {
            return performRequest(route: .getHistoryPromotion(parameter: parameter))
        }
    }
    
    static func getUserBettingRecord(filter: String, platformCode: String, groupCode: String) -> Future<KKUserBettingHistoryResponse> {
        let parameter = [
            APIKeys.filterDuration : filter,
            APIKeys.groupCode : groupCode,
            APIKeys.platformCode: platformCode
        ] as [String : Any]
        
        return performRequest(route: .getUserBettingRecord(parameter: parameter))
    }
    
    static func getVipLevel() -> Future<KKVipResponse> {
        return performRequest(route: .vipLevel)
    }
    
    //MARK: - Inbox
    static func getInbox() -> Future<KKInboxMessageResponse> {
        let parameter = [
            APIKeys.locale: KKUtil.decodeUserLanguageFromCache().locale!
        ] as [String : Any]
        
        return performRequest(route: .getInbox(parameter: parameter))
    }
    
    static func getInboxReadStatus() -> Future<KKInboxUnreadResponse> {
        return performRequest(route: .getInboxReadStatus)
    }
    
    static func updateInboxReadStatus(msgId: Int) -> Future<KKGeneralResponse> {
        let parameter = [
            APIKeys.inboxMessageId    : msgId
        ] as [String : Any]
        
        return performRequest(route: .updateInboxReadStatus(parameter: parameter))
    }
    
    //MARK: - Rebate
    static func getRebateProfile() -> Future<KKRebateProfileResponse> {
        return performRequest(route: .rebateProfile)
    }
    
    static func getRebatePayout(filter:String) -> Future<KKPayoutResponse> {
        let parameter = [
            APIKeys.filterDuration: filter
        ] as [String : Any]
        
        return performRequest(route: .rebatePayout(parameter: parameter))
    }
    
    static func getRebateTransaction(filter: String, type: String) -> Future<KKTransactionResponse> {
        let parameter = [
            APIKeys.filterDuration: filter,
            APIKeys.type: type
        ] as [String : Any]
        
        return performRequest(route: .rebateTransaction(parameter: parameter))
    }
    
    static func getRebateTable() -> Future<KKTableResponse> {
        return performRequest(route: .rebateTable)
    }
    
    static func rebateCollect(amount: String) -> Future<KKGeneralResponse> {
        let parameter = [
            APIKeys.amount: amount
        ] as [String : Any]
        
        return performRequest(route: .rebateCollect(parameter: parameter))
    }
    
    //MARK: - Affiliate
    static func getMyAffiliate() -> Future<KKAffiliateProfileResponse> {
        return performRequest(route: .myAffiliate)
    }
    
    static func getAffiliateGuideline() -> Future<KKGuidelineResponse> {
        let parameter = [
            APIKeys.locale: KKUtil.decodeUserLanguageFromCache().locale!
        ] as [String : Any]
        
        return performRequest(route: .getAffiliateGuideline(parameter: parameter))
    }
    
    static func getAffiliateDownline() -> Future<KKAffiliateDownlineResponse> {
        return performRequest(route: .affiliateDownline)
    }
    
    static func getAffiliateTurnover(filter: String) -> Future<KKAffiliateTurnoverResponse> {
        let parameter = [
            APIKeys.filterDuration: filter
        ] as [String : Any]
        
        return performRequest(route: .affiliateTurnover(parameter: parameter))
    }
    
    static func getAffiliatePayout(filter: String) -> Future<KKPayoutResponse> {
        let parameter = [
            APIKeys.filterDuration: filter
        ] as [String : Any]
        
        return performRequest(route: .affiliatePayout(parameter: parameter))
    }
    
    static func getAffiliateCommissionTransaction(filter: String, type: String) -> Future<KKTransactionResponse> {
        let parameter = [
            APIKeys.filterDuration: filter,
            APIKeys.type: type
        ] as [String : Any]
        
        return performRequest(route: .affiliateCommissionTransaction(parameter: parameter))
    }
    
    static func getAffiliateCommissionTable() -> Future<KKTableResponse> {
        return performRequest(route: .commissionTable)
    }
    
    static func affiliateCollect(amount: String) -> Future<KKGeneralResponse> {
        let parameter = [
            APIKeys.amount: amount
        ] as [String : Any]
        
        return performRequest(route: .affiliateCollect(parameter: parameter))
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
    
    //MARK:- Device Register/Remove
    
    static func deviceRegister() -> Future<KKGeneralResponse> {
                
        let parameter = [
            APIKeys.inUse: 1,
            APIKeys.appVersion: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String,
            APIKeys.os: Platform.iOS,
            APIKeys.deviceToken: UserDefaults.standard.string(forKey: CacheKey.deviceToken) ?? "empty",
            APIKeys.model: UIDevice.modelName,
            APIKeys.osVersion: UIDevice.current.systemVersion,
            APIKeys.uuid: UIDevice.current.identifierForVendor!.uuidString,
            APIKeys.brand: Brand.apple
        ] as [String : Any]
        
        return performRequest(route: .deviceRegister(parameter: parameter))
    }
    
    static func deviceRemoved() -> Future<KKGeneralResponse> {
        
        return performRequest(route: .deviceRemoved(uuid: UIDevice.current.identifierForVendor!.uuidString))
    }
}

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
