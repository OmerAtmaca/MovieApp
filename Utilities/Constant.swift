//
//  Constant.swift
//  MovieApp
//
//  Created by ömer atmaca on 17.09.2023.
//

import Foundation
import UIKit

struct Constants {
    struct General {
        static let appTitle = "ios-base"
        static let missingUUID = "none"
        static let missingFcmToken = "none"
        static let appstoreLink = "https://apps.apple.com/app/id1561464564"
    }

    struct Networking {
        static var baseURL: String {
            Environment.baseURL
        }
        
        static var apiKey: String {
            Environment.apiKey
        }

        static var header: [String: String?] {
            ["accept": "application/json",
             "Authorization": "Bearer \(LocalStorage.shared.token ?? "")"
            ]
        }
    }

    struct Icon {
        struct Arrow {
            static let downBoldRounded      = UIImage(named: "ic_arrowDown_bold_rounded")
            static let downBoldSquare       = UIImage(named: "ic_arrowDown_bold_square")
            static let downLightRounded     = UIImage(named: "ic_arrowDown_light_rounded")
            static let leftBoldRounded      = UIImage(named: "ic_arrowLeft_bold_rounded")
            static let leftBoldSquare       = UIImage(named: "ic_arrowLeft_bold_square")
            static let leftLightRounded     = UIImage(named: "ic_arrowLeft_light_rounded")
            static let rightBoldRounded     = UIImage(named: "ic_arrowRight_bold_rounded")
            static let rightBoldSquare      = UIImage(named: "ic_arrowRight_bold_square")
            static let rightLightRounded    = UIImage(named: "ic_arrowRight_light_rounded")
            static let upBold1Rounded       = UIImage(named: "ic_arrowUp_bold_rounded")
            static let upBold1Square        = UIImage(named: "ic_arrowUp_bold_square")
            static let upLightRounded       = UIImage(named: "ic_arrowUp_light_rounded")
        }
        
        //New Icons
        struct Colored {
            static let circleCrossOrange    = UIImage(named: "ic_colored_circleCrossOrange")
            static let circleMinusOrange    = UIImage(named: "ic_colored_circleMinusOrange")
            static let circlePlusOrange     = UIImage(named: "ic_colored_circlePlusOrange")
            static let circleThickOrange    = UIImage(named: "ic_colored_circleThickOrange")
            static let bagWhite             = UIImage(named: "ic_colored_bagWhite")
        }
        
        struct Sign {
            static let circle               = UIImage(named: "ic_sign_circle")
            static let crossSquare          = UIImage(named: "ic_sign_cross_square")
            static let cross                = UIImage(named: "ic_sign_cross")
            static let plus                 = UIImage(named: "ic_sign_plus")
            static let questionMark         = UIImage(named: "ic_sign_questionMark")
            static let thickSquare          = UIImage(named: "ic_sign_thick_square")
            static let thickRounded         = UIImage(named: "ic_sign_thick_rounded")
            static let minusFilled          = UIImage(named: "ic_sign_minus_filled")
            static let plusFilled           = UIImage(named: "ic_sign_plus_filled")
            static let crossFilled          = UIImage(named: "ic_sign_cross_filled")
            static let thickFilled          = UIImage(named: "ic_sign_thick_filled")
            static let crossSmallFilled     = UIImage(named: "ic_sign_cross_small_filled")
            static let thickSmallFilled     = UIImage(named: "ic_sign_thick_small_filled")
        }
        
        struct Main {
            static let attach               = UIImage(named: "ic_main_attach")
            static let bagEmpty             = UIImage(named: "ic_main_bag_empty")
            static let bagFilled            = UIImage(named: "ic_main_bag_filled")
            static let bank                 = UIImage(named: "ic_main_bank")
            static let barcodeScan          = UIImage(named: "ic_main_barcode_scan")
            static let barcode              = UIImage(named: "ic_main_barcode")
            static let bell                 = UIImage(named: "ic_main_bell")
            static let boardCards           = UIImage(named: "ic_main_boardCards")
            static let cake                 = UIImage(named: "ic_main_cake")
            static let cash                 = UIImage(named: "ic_main_cash")
            static let camera               = UIImage(named: "ic_main_camera")
            static let cameraSwitch         = UIImage(named: "ic_main_camera_switch")
            static let cardCredit           = UIImage(named: "ic_main_card_credit")
            static let cardGift             = UIImage(named: "ic_main_card_gift")
            static let categories           = UIImage(named: "ic_main_categories")
            static let chatBubbleEmpty      = UIImage(named: "ic_main_chatBubble_empty")
            static let chatBubbleTwin       = UIImage(named: "ic_main_chatBubble_twin")
            static let clockCircle          = UIImage(named: "ic_main_clock_circle")
            static let clockDelivery        = UIImage(named: "ic_main_clock_delivery")
            static let cloudUpload          = UIImage(named: "ic_main_cloud_upload")
            static let commentHeart         = UIImage(named: "ic_main_comment_heart")
            static let copy                 = UIImage(named: "ic_main_copy")
            static let deliveryMoving       = UIImage(named: "ic_main_delivery_moving")
            static let deliveryStill        = UIImage(named: "ic_main_delivery_still")
            static let discount             = UIImage(named: "ic_main_discount")
            static let dollarCircle         = UIImage(named: "ic_main_dollar_circle")
            static let dollarExchange       = UIImage(named: "ic_main_dollar_exchange")
            static let doc                  = UIImage(named: "ic_main_doc")
            static let docCopy              = UIImage(named: "ic_main_doc_copy")
            static let docLook              = UIImage(named: "ic_main_doc_look")
            static let eyeOn                = UIImage(named: "ic_main_eye_on")
            static let filter               = UIImage(named: "ic_main_filter")
            static let gallery              = UIImage(named: "ic_main_gallery")
            static let galleryTriple        = UIImage(named: "ic_main_gallery_triple")
            static let handReturn           = UIImage(named: "ic_main_hand_return")
            static let hanger               = UIImage(named: "ic_main_hanger")
            static let heartEmpty           = UIImage(named: "ic_main_heart_empty")
            static let heartFilled          = UIImage(named: "ic_main_heart_filled")
            static let home                 = UIImage(named: "ic_main_home")
            static let homePerson           = UIImage(named: "ic_main_home_person")
            static let infoCircle           = UIImage(named: "ic_main_info_circle")
            static let key                  = UIImage(named: "ic_main_key")
            static let lamp                 = UIImage(named: "ic_main_lamp")
            static let linkChain            = UIImage(named: "ic_main_linkChain")
            static let locationArrowCircle  = UIImage(named: "ic_main_locationArrow_circle")
            static let lock                 = UIImage(named: "ic_main_lock")
            static let logout               = UIImage(named: "ic_main_logout")
            static let mail                 = UIImage(named: "ic_main_mail")
            static let mapPinAlone          = UIImage(named: "ic_main_mapPin_alone")
            static let mapPinOnCircle       = UIImage(named: "ic_main_mapPin_onCircle")
            static let mapTarget            = UIImage(named: "ic_main_mapTarget")
            static let measure              = UIImage(named: "ic_main_measure")
            static let megaphone            = UIImage(named: "ic_main_megaphone")
            static let micFilled            = UIImage(named: "ic_main_mic_filled")
            static let micEmpty             = UIImage(named: "ic_main_mic_empty")
            static let orderDropoff         = UIImage(named: "ic_main_order_dropoff")
            static let orderReturn          = UIImage(named: "ic_main_order_return")
            static let orderStatus          = UIImage(named: "ic_main_order_status")
            static let order                = UIImage(named: "ic_main_order")
            static let packageGift          = UIImage(named: "ic_main_package_gift")
            static let packagePut           = UIImage(named: "ic_main_package_put")
            static let pencil               = UIImage(named: "ic_main_pencil")
            static let personAdd            = UIImage(named: "ic_main_person_add")
            static let personEmpty          = UIImage(named: "ic_main_person_empty")
            static let personFilled         = UIImage(named: "ic_main_person_filled")
            static let personKey            = UIImage(named: "ic_main_person_key")
            static let playCircle           = UIImage(named: "ic_main_play_circle")
            static let play                 = UIImage(named: "ic_main_play")
            static let receipt              = UIImage(named: "ic_main_receipt")
            static let questionMarkCircle   = UIImage(named: "ic_main_questionMark_circle")
            static let search               = UIImage(named: "ic_main_search")
            static let searchBug            = UIImage(named: "ic_main_search_bug")
            static let secure               = UIImage(named: "ic_main_secure")
            static let settings             = UIImage(named: "ic_main_settings")
            static let share                = UIImage(named: "ic_main_share")
            static let smileyCircle         = UIImage(named: "ic_main_smiley_circle")
            static let sort                 = UIImage(named: "ic_main_sort")
            static let speedUp              = UIImage(named: "ic_main_speedUp")
            static let starCircle           = UIImage(named: "ic_main_star_circle")
            static let starEmpty            = UIImage(named: "ic_main_star_empty")
            static let starFilled           = UIImage(named: "ic_main_star_filled")
            static let storePackages        = UIImage(named: "ic_main_store_packages")
            static let studentAccount       = UIImage(named: "ic_main_student_account")
            static let thumbsUp             = UIImage(named: "ic_main_thumbsUp")
            static let thunderSharp         = UIImage(named: "ic_main_thunder_sharp")
            static let thunderWide          = UIImage(named: "ic_main_thunder_wide")
            static let trash                = UIImage(named: "ic_main_trash")
            static let triangleWarning      = UIImage(named: "ic_main_triangle_warning")
            static let tryOnYou             = UIImage(named: "ic_main_tryOnYou")
            static let wallet               = UIImage(named: "ic_main_wallet")
            
        }
    }

    struct Logo {
        static let appleTemplate        = UIImage(named: "logo_apple_template")
        static let facebookTemplate     = UIImage(named: "logo_facebook_template")
        static let facebookColored      = UIImage(named: "logo_facebook_colored")
        static let googleTemplate       = UIImage(named: "logo_google_template")
        static let googleColored        = UIImage(named: "logo_google_colored")
        static let twitterTemplate      = UIImage(named: "logo_twitter_template")
        static let mastercardColored    = UIImage(named: "logo_mastercard_colored")
        static let mastercardTemplate   = UIImage(named: "logo_mastercard_template")
        static let visaColored          = UIImage(named: "logo_visa_colored")
        static let visaTemplate         = UIImage(named: "logo_visa_template")
        static let aramex               = UIImage(named: "logo_aramex")
        static let valu                 = UIImage(named: "logo_valu")
        static let valuVPopup           = UIImage(named: "logo_valu_vPopup")
    }

    struct Image {
        static let onboardingBarcode    = UIImage(named: "img_onboarding_barcode")
        static let onboardingPhoto1     = UIImage(named: "img_onboarding_photo1")
        static let onboardingPhoto2     = UIImage(named: "img_onboarding_photo2")
        static let onboardingPhoto3     = UIImage(named: "img_onboarding_photo3")
        static let referAndEarnTopImg   = UIImage(named: "img_referAndEarn_topImage")
        static let orderSuccess         = UIImage(named: "img_orderSuccess")
        static let orderFailed          = UIImage(named: "ic_payment_error")
    }

    struct Text {
        static var error: String { "error".localized() }
        static var info: String { "info".localized() }
        static var ok: String { "OK".localized() }
        static var success: String { "Success".localized() }
        static var invalidEmail: String { "sign in invalid email".localized() }
        static var invalidPassword: String { "sign in password rule".localized() }
        static var nameError: String { "Fields can not be left empty!".localized() }
    }

    struct UserDefaultsKey {
        static let token = "UserTokenKey"
        static let refreshToken = "UserRefreshTokenKey"
        static let fcmToken = "FcmTokenKey"
        static let nowPlaying = "NoPlayingKey"
    }

    struct Error {
        static var networkFailure: String  { "Something went wrong :(" }
        static var backendFailure: String { "Oops! We are sorry :(" }
    }
    
    struct Fonts {

    }

    struct Radius {
       
    }

    enum GTNotification {
        enum Key {
            static let object: String = "object"
            static let type: String = "type"
        }

        enum NotificationCenterKey {
            static let productId = "productId"
            static let settings = "settings"
            static let homeIconUrl = "homeIconUrl"
            static let categoriesIconUrl = "categoriesIconUrl"
            static let bagIconUrl = "bagIconUrl"
            static let wishlistIconUrl = "wishlistIconUrl"
            static let accountIconUrl = "accountIconUrl"
            static let introVideoUrl = "introVideoUrl"
        }
    }

    enum FAQQuery {
        enum Key {
            static let userId: String = "userId"
            static let fullName: String = "fullName"
            static let email: String = "email"
        }
    }
}

//MARK: Notification center values
extension Notification.Name {
    static let addMarketBadge = Notification.Name("NotificationAddMarketBadge")
}
