//
//  KKConstant.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import Foundation
import UIKit

struct ScreenSize {
    
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let maxLength = max(width, height)
    static let minLength = min(width, height)
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
    static let leftNotchWidth = CGFloat(44)
    static let navBarHeight = CGFloat(60)
}

struct ConstantSize {
    
    static let paddingStandard = CGFloat(24)
    static let paddingSecondary = CGFloat(16)
    
    static let paddingDouble = paddingStandard*2
    static let paddingHalf = paddingStandard/2
    
    static let paddingSecondaryDouble = paddingSecondary*2
    static let paddingSecondaryHalf = paddingSecondary/2
    
    static let textFieldHeight = CGFloat(40)
    static let textFieldSeperatorHeight = CGFloat(1)
    
    static let navBarBtnWidth = CGFloat(65)
    static let navBarSeperatorHeight = CGFloat(2)

    static let ssoLabelFont = KKUtil.ConvertSizeByDensity(size: 12)
    static let ssoLabelSmallFont = KKUtil.ConvertSizeByDensity(size: 10)
    
    static let sideMenuWidth = KKUtil.ConvertSizeByDensity(size: 160)
    static let menuItemHeight = KKUtil.ConvertSizeByDensity(size: 45)
    static let imgMenuIconWidth = KKUtil.ConvertSizeByDensity(size: 20)
    static let menuItemMarginLeft = KKUtil.ConvertSizeByDensity(size: 15)
    static let separatorHeight = KKUtil.ConvertSizeByDensity(size: 2)
    static let sideMenuSelectedFont = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
    static let sideMenuFont = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))

    static let imgBackWidth = KKUtil.ConvertSizeByDensity(size: 35)
    static let headerContainerMarginLeft = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 20 : 30)
    
    static let ssoPopUpWidth = KKUtil.isSmallerPhone() ? ScreenSize.maxLength * 0.75 : ScreenSize.maxLength * 0.6
    static let ssoPopUpHeight = ScreenSize.minLength - paddingStandard * 2
    
    static let headerBarWidth = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 300 : 310)
}

struct CacheKey {
    static let loginStatus = "login_status"
    static let accessToken = "access_token"
    static let refreshToken = "refresh_token"
    static let userProfile = "user_profile"
    static let appVersionDetails = "app_version_details"
    static let selectedCountry = "selected_country"
    static let selectedLanguage = "selected_language"
    static let username = "username"
    static let secret = "secret"
    static let rememberMe = "remember_me"
    static let deviceToken = "device_token"
}

struct APIKeys {
    static let platform = "p"
    static let code = "code"
    static let phoneNumber = "phone_number"
    static let OTPCode = "otp_code"
    static let email = "email"
    static let username = "username"
    static let password = "password"
    static let currentPassword = "current_password"
    static let confirmPassword = "confirm_password"
    static let newPassword = "new_password"
    static let confirmNewPassword = "confirm_new_password"
    static let gender = "gender"
    static let birthday = "birthday"
    static let type = "type"
    static let registrationPlatform = "register_platform"
    static let locale = "locale"
    static let countryCode = "country_code"
    static let groupCode = "group_code"
    static let platformCode = "platform_code"
    static let gameTypeCode = "game_type_code"
    static let status = "status"
    static let receipt = "receipt"
    static let promotionCode = "promotion_code"
    static let depositChannelCode = "deposit_channel_code"
    static let referenceNumber = "reference_number"
    static let depositAmount = "deposit_amount"
    static let depositTime = "deposit_time"
    static let companyBankID = "company_bank_id"
    static let bankID = "bank_id"
    static let bankAccountName = "bank_account_name"
    static let bankAccountNo = "bank_account_number"
    static let withdrawAmount = "withdraw_amount"
    static let userBankCardId = "user_bank_card_id"
    static let withdrawAccountNo = "bank_account_number"
    static let filterDuration = "filter_duration"
    static let filterType = "filter_type"
    static let inboxMessageId = "inbox_message_id"
    static let transStatus = "trans_status"
    static let bankAccountCardId = "bank_account_card_id"
    static let avatarId = "avatar_id"
    static let amount = "amount"
    static let faqCode = "faq_code"
    static let inUse = "in_use"
    static let appVersion = "app_version"
    static let os = "os"
    static let deviceToken = "device_token"
    static let model = "model"
    static let osVersion = "os_version"
    static let uuid = "uuid"
    static let brand = "brand"
}

struct APIValue {
    static let last90Days = "l90d"
}

struct Platform {
    static let iOS = "ios"
}

struct Brand {
    static let apple = "Apple"
}

struct LoginType {
    static let username = "username"
}

struct RegistrationType {
    static let phoneNumber = "phone_number"
}

struct CountryCode {
    static let Malaysia     = "MYS"
    static let Thailand     = "THA"
    static let Singapore    = "SGP"
    static let Indonesia    = "IDN"
}

struct CurrencyCode {
    static let Malaysia     = "MYR"
    static let Thailand     = "THB"
    static let Singapore    = "SGD"
    static let Indonesia    = "IDR"
}

struct LocaleCode {
    static let English = "en"
    static let Thailand = "th"
    static let Malay = "ms"
    static let Mandarin = "zh"
}

struct LocaleName {
    static let English = "English"
    static let Thailand = "Thailand"
    static let Malay = "Malay"
    static let Mandarin = "Mandarin"
}

struct CellIdentifier {
    
    static let sideMenuTVCIdentifier = "KKSideMenuTableCell"
    static let announcementTVCIdentifier = "KKAnnouncementTableCell"
    static let bankTVCIdentifier = "KKBankTableCell"
    static let bonusTVCIdentifier = "KKBonusMenuTableCell"
    static let messageTVCIdentifier = "KKMessageTableCell"
    

    static let liveChatCVCIdentifier = "KKLiveChatCollectionViewCell"
    static let countryCVCIdentifier = "KKCountryItemCell"
    static let liveCasinoCVCIdentifier = "KKLiveCasinoItemCell"
    static let gameItemCVCIdentifier = "KKSingleRowGameItemCell"
    static let gameMenuItemCVCIdentifier = "KKGameMenuItemCell"
    static let bonusItemCVCIdentifier = "KKBonusItemCell"
    
    static let generalHeaderViewIdentifier = "KKGeneralHeaderViewIdentifier"
    static let generalItemCellIdentifier = "KKGeneralItemCellIdentifier"
    static let tabListItemCVCIdentifier = "KKTabListItemCell"
    static let platformGameItemCVCIdentifier = "KKPlatfromGameItemCell"
    static let avatarItemCVCIdentifier = "KKAvatarItemCell"
    static let vipItemCVCIdentifier = "KKVipItemCell"
}

struct Spade {
    
    struct StagingServer {
        static let baseApiURL: String = "https://dev-apis.lg88.dev/api/"
    }
    
    struct ProdServer {
        static let baseApiURL: String = "https://live-lg-api.fteg.app/api/"
    }
    
    struct OneSignalCredential {
        static let appID: String = "69fe838a-30bf-4eaa-b986-bbb01d48644d"
    }
}



struct GameType {
    static let hotGame = 0
    static let slots = 1
    static let fishing = 2
    static let liveCasino = 3
    static let p2pGame = 4
    static let sports = 5
    static let lottery = 6
    static let esports = 7
}

enum HTTPHeaderField: String {
    
    case contentType = "Content-Type"
    case authorization = "Authorization"
    case accept = "Accept"
}

enum HTTPHeaderFieldValue: String {
    case contentType = "application/json"
    case multipartContentType = "multipart/form-data"
}

enum TableViewType: Int, CaseIterable {
    
    case BettingRecord = 1
    case AccountDetails = 2
    case DepositHistory = 3
    case WithdrawHistory = 4
    case History = 5

    case AffiliateDownline = 6
    case AffiliateTurnover = 7
    case AffiliatePayout = 8
    case AffiliateCommTrans = 9
    case AffiliateCommTable = 10
    
    case RebatePayout = 11
    case RebateTrans = 12
    case RebateTable = 13
}

enum PopupTableViewType: Int, CaseIterable {
    case NonCommGame = 1
    case NonRebateGame = 2
    case RebateDetail = 3
}

enum FilterDuration: String, CaseIterable {
    case all = "all"
//    case td = "td"
//    case yd = "yd"
    case l7d = "l7d"
//    case tm = "tm"
//    case lm = "lm"
    case l30d = "l30d"
//    case l90d = "l90d"
}

enum HistoryStatus: String, CaseIterable {
    case all = "all"
    case success = "success"
    case fail = "fail"
    case pending = "pending"
}

enum HistoryTab: String, CaseIterable {
    case deposit = "deposit"
    case withdraw = "withdraw"
    case transfer = "transfer"
    case promotion = "promotion"
}

enum GenderType: String, CaseIterable {
    case male = "Male"
    case female = "Female"
}

enum TransactionType: String, CaseIterable {
    case all = "all"
    case payout = "payout"
    case collect = "collect"
}

enum DialogAlertType: Int {
    case Logout = 1
    case Deposit = 2
    case Withdraw = 3
    case ExitGame = 4
}

enum ToastType: String {
    case Success = "success"
    case Error = "error"
}

///Side Menu
enum PersonalSideMenu: Int, CaseIterable {
    case userInfo = 0
    case bettingRecord = 1
    case accountDetail = 2
    case wallet = 3
    case bankCard = 4
    case history = 5
}

enum AffiliatteSideMenu: Int, CaseIterable {
    case myAffiliate = 0
    case guideline = 1
    case downline = 2
    case turnover = 3
    case payout = 4
    case commissionTrans = 5
    case commissionTable = 6
}

enum RebateSideMenu: Int, CaseIterable {
    case myRebate = 0
    case payout = 1
    case rebateTrans = 2
    case rebateTable = 3
}

enum MessageSideMenu: Int, CaseIterable {
    case systemMail = 0
//    case notification = 1
}

enum SupportSideMenu: Int, CaseIterable {
    case liveChat = 0
    case faq = 1
}

enum DepositSideMenu: Int, CaseIterable {
    case bankAccount = 0
    case depositHistory = 1
    case artificial = 2
}

enum WithdrawSideMenu: Int, CaseIterable {
    case withdraw = 0
    case withdrawHistory = 1
}

enum SettingsSideMenu: Int, CaseIterable {
    case volumeSetting = 0
    case changePassword = 1
    case version = 2
    case logout = 3
}
